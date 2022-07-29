local builder = Snip.create_snippet_builder("rust")
local h = builder.helpers

builder.snip(h.snippet(
  "modtest",
  h.fmt(
    [[
#[cfg(test)]
mod test {{
{}

    {}
}}
        ]],
    {
      h.choice(1, { h.t("\tuse super::*;"), h.t("") }),
      h.i(0),
    }
  )
))

builder.build()
