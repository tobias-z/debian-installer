local builder = Snip.create_snippet_builder("javascript", "javascriptreact", "typescript", "typescriptreact")

builder.vscode_snip("func", "function $1($2) {\n\t$0\n}")
builder.vscode_snip("afunc", "async function $1($2) {\n\t$0\n}")
builder.vscode_snip("cl", "console.log($0);")
builder.vscode_snip("class", Multiline_string("class $1 {", "\t$0", "}"))

builder.vscode_snip(
  "try",
  Multiline_string("try {", "\t$0", "} catch(error) {", "\tconsole.error(error.message);", "}")
)

builder.vscode_snip(
  "tryfinally",
  Multiline_string("try {", "\t$0", "} catch(error) {", "\tconsole.error(error.message);", "} finally {", "\t$1", "}")
)

builder.vscode_snip(
  "redf",
  Multiline_string(
    "function $1(state, action) {",
    "\tswitch (action.type) {",
    '\t\tcase "$0":',
    "\t\t\treturn",
    "\t\tdefault:",
    "\t\t\treturn state",
    "\t}",
    "}"
  )
)

-- tests
builder.vscode_snip("testcase", Multiline_string("test('$1', () => {", "\t$0", "})"))

builder.build()
