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
	indent = { enable = true, disable = { "python" } }, --python indenting is actually broken
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
	},
	-- auto install above language parsers
	auto_install = true,
})
