local M = {}

M.search_vimrc = function()
	require("telescope.builtin").find_files({
		prompt_title = "VimRC",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end

M.project_files = function()
	local ok = pcall(require("telescope.builtin").git_files)
	if not ok then
		require("telescope.builtin").find_files()
	end
end

return M
