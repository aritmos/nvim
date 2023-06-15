-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true, disable = { "python" } }, --python indenting is currently broken
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"lua",
		"rust",
		"python",
		"toml",
		"markdown_inline",
		"kdl",
		"zig",
	},
	-- auto install above language parsers
	auto_install = true,
})

vim.api.nvim_set_hl(0, "@comment.rust", { link = "SagaBorder" }) -- adds background to differentiate it from inlay hints
