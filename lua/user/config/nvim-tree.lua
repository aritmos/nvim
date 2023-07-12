local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	print("nvim-tree is not installed")
	return
end

-- recommended settings from the documentation
vim.g.loaded = 1
vim.g.loaded_newtrPlugin = 1

M = {}
local api = require("nvim-tree.api")

local function opts(desc)
	return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

function M.on_attach(bufnr)
	-- default maps
	api.config.mappings.default_on_attach(bufnr)

	-- custom maps
	vim.keymap.del("n", "<Tab>", { buffer = bufnr })
	vim.keymap.set("n", "<Tab>", M.cd, opts("CD"))
end

function M.cd()
	local node = api.tree.get_node_under_cursor()
	-- print("cd: " .. node.absolute_path)
	vim.api.nvim_command("cd " .. node.absolute_path)
end

nvimtree.setup({
	git = { enable = false },
	on_attach = M.on_attach,
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
})

vim.api.nvim_create_autocmd({ "QuitPre" }, {
	callback = function()
		vim.cmd("NvimTreeClose")
	end,
})
