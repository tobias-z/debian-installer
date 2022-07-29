local builder = Snip.create_snippet_builder("all")
local h = builder.helpers

builder.snip(h.snippet(
  "curtime",
  h.f(function()
    return os.date("%D - %H:%M")
  end)
))

builder.build()
