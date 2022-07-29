local builder = Snip.create_snippet_builder("tex")
local h = builder.helpers
local helpers = Snip.create_function_helpers(builder.helpers.f)

builder.vscode_snip("package", [[\usepackage{$0}]])

builder.snip(h.snippet(
  "begin",
  h.fmt(
    [[
\begin{{{}}}
{}
\end{{{}}}
]],
    { h.i(1), h.i(0), helpers.same(1) }
  )
))

builder.snip(h.snippet(
  "items",
  h.fmt(
    [[
\begin{{itemize}}
    \item {}
\end{{itemize}}
]],
    { h.i(0) }
  )
))

builder.build()
