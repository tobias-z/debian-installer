local builder = Snip.create_snippet_builder("go")
local h = builder.helpers
local functions = Snip.create_function_helpers(h.f)

builder.vscode_snip(
  "func",
  [[
func $1($2) {
    $0
}]]
)

builder.snip(h.snippet(
  "method",
  h.fmt(
    [[
func ({} {}) {}({}) {} {{
    {}
}}
]],
    {
      h.i(1),
      h.choice(2, {
        functions.same(1),
        functions.same_first_to_upper(1),
        h.t(""),
      }),
      h.i(3),
      h.i(4),
      h.i(5),
      h.i(0),
    }
  )
))

builder.snip(h.snippet(
  "efi",
  h.fmt(
    [[
{}, {} := {}({})

if {} != nil {{
    return {}
}}
{}
    ]],
    {
      h.i(1, { "val" }),
      h.i(2, { "err" }),
      h.i(3, { "" }),
      h.i(4),
      functions.same(2),
      h.i(5),
      h.i(0),
    }
  )
))

builder.snip(h.snippet(
  "ef",
  h.fmt([[{}, {} := {}({})]], {
    h.i(1, { "val" }),
    h.i(2, { "err" }),
    h.i(3, { "f" }),
    h.i(4),
  })
))

builder.vscode_snip("sout", [[fmt.Println($0)]])

-- testing

builder.vscode_snip(
  "testcase",
  [[
func Test$1(t *testing.T) {
    $0
}
]]
)

builder.build()
