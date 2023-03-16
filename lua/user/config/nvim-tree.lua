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
	vim.keymap.set("n", "<S-Tab>", M.cd, opts("CD"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

function M.cd()
	local node = api.tree.get_node_under_cursor()
	print("cd: " .. node.absolute_path)
	vim.api.nvim_command("cd " .. node.absolute_path)
end

nvimtree.setup({
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
	-- view = {
	-- 	mappings = {
	-- 		list = {
	-- 			{ key = "<Tab>", action = "cd" },
	-- 		},
	-- 	},
	-- },
})

local function tab_win_closed(winnr)
	local api = require("nvim-tree.api")
	local tabnr = vim.api.nvim_win_get_tabpage(winnr)
	local bufnr = vim.api.nvim_win_get_buf(winnr)
	local buf_info = vim.fn.getbufinfo(bufnr)[1]
	local tab_wins = vim.tbl_filter(function(w)
		return w ~= winnr
	end, vim.api.nvim_tabpage_list_wins(tabnr))
	local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
	if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
		-- Close all nvim tree on :q
		if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
			api.tree.close()
		end
	else -- else closed buffer was normal buffer
		if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
			local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
			if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
				vim.schedule(function()
					if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
						vim.cmd("quit") -- then close all of vim
					else -- else there are more tabs open
						vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
					end
				end)
			end
		end
	end
end

vim.api.nvim_create_autocmd("WinClosed", {
	callback = function()
		local winnr = tonumber(vim.fn.expand("<amatch>"))
		vim.schedule_wrap(tab_win_closed(winnr))
	end,
	nested = true,
})
