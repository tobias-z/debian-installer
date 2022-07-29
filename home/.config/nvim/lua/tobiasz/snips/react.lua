local builder = Snip.create_snippet_builder("javascriptreact", "typescriptreact")
local h = builder.helpers
local functions = Snip.create_function_helpers(h.f)

builder.vscode_snip(
  "rfc",
  Multiline_string("export default function $1() {", "\treturn (", "\t\t<div>", "\t\t\t$0", "\t\t</div>", "\t);", "}")
)

builder.snip(
  h.snippet("us", h.fmt([[const [{}, set{}] = useState({});]], { h.i(1), functions.same_first_to_upper(1), h.i(0) }))
)
builder.vscode_snip("uef", Multiline_string("useEffect(() => {", "\t$0", "}, [])"))

builder.build()
