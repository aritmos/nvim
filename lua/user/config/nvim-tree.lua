local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	print("nvim-tree is not installed")
	return
end

-- recommended settings from the documentation
vim.g.loaded = 1
vim.g.loaded_newtrPlugin = 1

nvimtree.setup({
	update_cwd = true,
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	tab = {
		sync = {
			open = true,
		},
	},
	view = {
		mappings = {
			list = {
				{ key = "<Tab>", action = "cd" },
			},
		},
	},
})

vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
			vim.cmd("quit")
		end
	end,
})
