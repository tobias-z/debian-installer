local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local telescope = require("telescope")

local search_theme = "dropdown"
local action_theme = "cursor"

local is_mac = vim.env.HOME:find("Users")

local function with_layout(table)
    -- table.borderchars = {
    --     { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    --     prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
    --     results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    --     preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    -- }
    table.prompt_title = false
    table.preview_title = false
    return table
end

local function search(with_preview)
    local search_no_preview = {
        theme = search_theme,
        layout_strategy = "vertical",
        layout_config = {
            height = 0.6,
            preview_cutoff = 10,
            preview_height = 0.4,
            prompt_position = "top",
            -- mirror = true,
        },
    }

    if not with_preview then
        search_no_preview.previewer = false
    end

    return with_layout(search_no_preview)
end

local function search_with_preview(_opts)
    return vim.tbl_deep_extend("force", search(true), _opts or {})
end

local function search_no_preview(_opts)
    return vim.tbl_deep_extend("force", search(false), _opts or {})
end

local no_preview = search_no_preview()
local with_preview = search_with_preview()

local cursor_layout = {
    width = 0.8,
    preview_width = 0.35,
    height = 0.4,
}

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
            Job
                :new({
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
                })
                :sync()
        end,
    },
    pickers = {
        find_files = no_preview,
        builtin = no_preview,
        live_grep = search_with_preview({ disable_coordinates = true }),
        grep_string = search_with_preview({ disable_coordinates = true }),
        current_buffer_fuzzy_find = no_preview,
        git_branches = no_preview,
        git_commits = no_preview,
        git_files = no_preview,
        git_status = with_preview,
        help_tags = with_preview,
        lsp_definitions = with_layout({
            theme = action_theme,
            layout_config = cursor_layout,
        }),
        lsp_implementations = with_layout({
            theme = action_theme,
            layout_config = cursor_layout,
        }),
        lsp_references = with_layout({
            theme = action_theme,
            layout_config = cursor_layout,
        }),
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_cursor(with_layout({
                theme = action_theme,
                layout_config = {
                    height = 0.25,
                },
            })),
        },
        project = no_preview,
        bookmarks = {
            -- Available: 'brave', 'buku', 'chrome', 'chrome_beta', 'edge', 'safari', 'firefox', 'vivaldi'
            selected_browser = "brave",

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
