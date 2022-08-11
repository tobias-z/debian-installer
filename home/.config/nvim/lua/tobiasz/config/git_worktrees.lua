local string_util = require("tobiasz.utils.string-util")

local Worktree = require("git-worktree")

vim.g.git_worktree_log_level = "warn"

Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    local branch_name
    if string.find(metadata.path, os.getenv("HOME") or "") then
      local idx = string_util.last_index_of(metadata.path, "/")
      branch_name = string.sub(metadata.path, idx + 1)
    else
      branch_name = metadata.path
    end
    vim.cmd("silent !tw restart 2_term " .. branch_name)
    vim.cmd("silent !tw restart 3_run " .. branch_name)
  end
end)
