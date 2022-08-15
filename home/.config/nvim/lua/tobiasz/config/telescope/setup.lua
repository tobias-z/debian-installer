local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local telescope = require("telescope")
local builders = require("tobiasz.config.telescope.builders")

local is_mac = vim.env.HOME:find("Users")

local no_preview = builders.search_no_preview()
local with_preview = builders.search_with_preview()

telescope.setup({
  defaults = {
    prompt_prefix = "〉",
    selection_caret = "〉",
    entry_prefix = "  ",
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
    -- dont preview binaries
    buffer_previewer_maker = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          else
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end,
      }):sync()
    end,
  },
  preview = {
    mime_hook = function(filepath, bufnr, opts)
      local is_image = function(fp)
        local image_extensions = { "png", "jpg" } -- Supported image formats
        local split_path = vim.split(fp:lower(), ".", { plain = true })
        local extension = split_path[#split_path]
        return vim.tbl_contains(image_extensions, extension)
      end
      if is_image(filepath) then
        local term = vim.api.nvim_open_term(bufnr, {})
        local function send_output(_, data, _)
          for _, d in ipairs(data) do
            vim.api.nvim_chan_send(term, d .. "\r\n")
          end
        end

        vim.fn.jobstart({
          "catimg",
          filepath, -- Terminal image viewer command
        }, { on_stdout = send_output, stdout_buffered = true })
      else
        require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
      end
    end,
  },
  pickers = {
    buffers = no_preview,
    find_files = no_preview,
    builtin = no_preview,
    live_grep = builders.search_with_preview({ disable_coordinates = true }),
    grep_string = builders.search_with_preview({ disable_coordinates = true }),
    current_buffer_fuzzy_find = no_preview,
    git_branches = no_preview,
    git_commits = no_preview,
    git_files = no_preview,
    git_status = with_preview,
    help_tags = with_preview,
    lsp_definitions = builders.cursor_theme(),
    lsp_implementations = builders.cursor_theme(),
    lsp_references = builders.cursor_theme(),
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor(builders.with_layout({
        theme = "cursor",
        layout_config = {
          height = 0.25,
        },
      })),
    },
    project = no_preview,
    bookmarks = {
      -- Available: 'brave', 'buku', 'chrome', 'chrome_beta', 'edge', 'safari', 'firefox', 'vivaldi'
      selected_browser = "firefox",

      -- Either provide a shell command to open the URL
      url_open_command = is_mac and "open" or "xdg-open",

      -- Show the full path to the bookmark instead of just the bookmark name
      full_path = true,
    },
    emoji = {
      action = function(emoji)
        vim.api.nvim_put({ emoji.value }, "c", false, true)
        -- vim.api.nvim_command(string.format(':call feedkeys("i"."%s")', emoji.value))
      end,
    },
  },
})

telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("project")
telescope.load_extension("node_modules")
telescope.load_extension("harpoon")
telescope.load_extension("refactoring")
telescope.load_extension("dap")
telescope.load_extension("bookmarks")
telescope.load_extension("emoji")
telescope.load_extension("gh")
telescope.load_extension("git_worktree")
