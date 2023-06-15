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
	{
		"stevearc/aerial.nvim",
		ft = codefiles,
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>ca", "<CMD>AerialToggle<CR>", { desc = "Aerial: Toggle" } },
		},
		config = function()
			require("user.config.aerial")
		end,
	},
	-- quality of life
	{
		"tpope/vim-surround",
		event = "BufReadPre",
	},
	{
		"vim-scripts/ReplaceWithRegister",
		keys = { { "gr" } },
		event = "VeryLazy",
	},
	{
		"windwp/nvim-autopairs",
		event = "BufReadPre",
		config = true,
	},
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.ai").setup({}) -- not really using it
			require("mini.comment").setup({})
			-- require("mini.pairs").setup({}) -- lags
			-- require("mini.surround").setup({}) -- doesn't work well
		end,
	},
}
