local builder = Snip.create_snippet_builder("markdown")

builder.vscode_snip("check", [[- [] $0]])

builder.build()
