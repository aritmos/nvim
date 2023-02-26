local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	print("Telescope is not setup")
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	print("Telescope actions are not setup")
	return
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
			},
		},
		file_ignore_patterns = {
			"debug",
			"target",
			"**/*.rs.bk",
			"lock",
			".pyc",
		},
	},
})

telescope.load_extension("fzy_native")
telescope.load_extension("file_browser")
