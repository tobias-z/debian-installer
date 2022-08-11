local luasnip = require("luasnip")

local function nvim_feedkeys(keys, opts)
  local replaced = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(replaced, opts or "n", true)
end

require("java_util").setup({
  lsp = {
    test = {
      use_defaults = true,
      after_snippet = function(opts)
        local has_jdtls, jdtls = pcall(require, "jdtls")
        if not has_jdtls then
          return
        end

        jdtls.organize_imports()
        if opts.is_luasnip then
          vim.defer_fn(function()
            local mode = vim.fn.mode()
            if mode == "n" then
              nvim_feedkeys("a")
            elseif mode == "s" then
              nvim_feedkeys("<esc>evb<C-G>")
            end
          end, 300)
        end
      end,
      class_snippets = {
        ["With test"] = function(info)
          return luasnip.parser.parse_snippet(
            "_",
            string.format(
              [[
package %s;

public class %s {

    @BeforeEach
    void setup() {
      // setup
    }

    @Test
    void ${2:helloWorld}() {
      $0
    }
}
                      ]],
              info.package,
              info.classname
            )
          )
        end,
      },
    },
  },
})
