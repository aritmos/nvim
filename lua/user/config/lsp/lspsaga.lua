-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
	-- use enter to open file with definition preview
	definition = {
		edit = "<CR>",
	},
	ui = {
		title = false,
		code_action = "A", -- change lightbulb
		border = "solid",
	},
	lightbulb = { -- "lightbulb" in gutter only
		enable = true,
		sign = true,
		sign_priority = 40,
		virtual_text = false,
	},
})
