Snip = {}

Snip.create_snippet_builder = function(language, ...)
  local languages = { language, unpack({ ... } or {}) }

  local ls = require("luasnip")
  local s = ls.s
  local fmt = require("luasnip.extras.fmt").fmt
  local i = ls.insert_node
  local t = ls.text_node
  local rep = require("luasnip.extras").rep
  local choice = ls.choice_node
  local f = ls.function_node
  local d = ls.dynamic_node
  local sn = ls.snippet_node

  local snippets = {}
  return {
    helpers = {
      snippet = s,
      fmt = fmt,
      i = i,
      t = t,
      f = f,
      d = d,
      rep = rep,
      choice = choice,
      sn = sn,
    },
    vscode_snip = function(name, snippet)
      table.insert(snippets, ls.parser.parse_snippet(name, snippet))
    end,
    snip = function(snippet)
      table.insert(snippets, snippet)
    end,
    build = function()
      for _, lang in ipairs(languages) do
        ls.add_snippets(lang, snippets)
      end
    end,
  }
end

Snip.create_function_helpers = function(f)
  local function first_to_upper(str)
    return (str:gsub("^%l", string.upper))
  end

  return {
    uppercase = function(index)
      return f(function(arg)
        return string.upper(arg[1][1])
      end, { index })
    end,
    same = function(index)
      return f(function(arg)
        return arg[1][1]
      end, { index })
    end,
    same_first_to_upper = function(index)
      return f(function(arg)
        return first_to_upper(arg[1][1])
      end, { index })
    end,
  }
end
