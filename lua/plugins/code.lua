local codefiles = require("user.config.code-files")

return {
	-- autocompletion
	{
		"hrsh7th/nvim-cmp",
		ft = codefiles,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",

			-- snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",

			-- lsp pictograms
			"onsails/lspkind.nvim",
		},
		config = function()
			require("user.config.nvim-cmp") -- cmp + luasnip
		end,
	},
	-- quality of life
	{
		"tpope/vim-surround",
		event = "BufReadPre",
	},
	{
		"vim-scripts/ReplaceWithRegister",
		event = "BufReadPre",
	},
	{
		"numToStr/Comment.nvim",
		keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		event = "BufReadPre",
		config = true,
	},
	-- {
	-- 	"akinsho/toggleterm.nvim",
	-- 	keys = {
	-- 		{ "<leader>tt", ":ToggleTerm size=40<cr>", desc = { "Toggle Terminal" } },
	-- 	},
	-- 	config = true,
	-- },
	-- {
	-- 	"xeluxee/competitest.nvim",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>cr", "<cmd>CompetiTestRun<cr>", desc = "Run Competitest" },
	-- 		{ "<leader>ca", "<cmd>CompetiTestAdd<cr>", desc = "Add Test" },
	-- 		{ "<leader>ce", "<cmd>CompetiTestEdit<cr>", desc = "Edit Test" },
	-- 	},
	-- 	config = function()
	-- 		require("user.config.competitest")
	-- 	end,
	-- },
}
