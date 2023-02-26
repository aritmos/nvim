local setup, betterTerm = pcall(require, "betterTerm")
if not setup then
	print("BetterTerm not installed")
	return
end
-- toggle firts term
vim.keymap.set({ "n", "t" }, "<leader>t", betterTerm.open, { desc = "Open terminal" })
-- Select term focus
vim.keymap.set({ "n", "t" }, "<leader>ts", betterTerm.select, { desc = "Select terminal" })
-- Create new term
local current = 2
vim.keymap.set({ "n", "t" }, "<leader>tn", function()
	betterTerm.open(current)
	current = current + 1
end, { desc = "New terminal" })

betterTerm.setup()
