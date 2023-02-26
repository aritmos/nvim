local codefiles = require("user.config.code-files")

return {
	-- lsp
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>pm", "<cmd>Mason<cr>", desc = "Plugins: Mason" } },
		dependencies = {
			"jayp0521/mason-null-ls.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("user.config.lsp.mason")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		ft = codefiles,
		dependencies = {
			"simrat39/rust-tools.nvim", -- config dependency
			"hrsh7th/cmp-nvim-lsp", -- config dependency
		},
		config = function()
			require("user.config.lsp.lspconfig")
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		ft = codefiles,
		branch = "main",
		cmd = "Lspsaga",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		config = function()
			require("user.config.lsp.lspsaga")
		end,
	},
	{
		"j-hui/fidget.nvim",
		ft = codefiles,
		config = function()
			require("fidget").setup({
				text = { spinner = "dots" },
			})
		end,
	},
	-- formatting & linting
	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = codefiles,
		dependencies = { "mason.nvim" },
		config = function()
			require("user.config.lsp.null-ls")
		end,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		ft = codefiles,
		keys = {
			{ "<leader>l", ":lua require('lsp_lines').toggle()<cr>", desc = "Lsp Lines: Toggle", silent = true },
		},
		config = function()
			require("lsp_lines").setup()
			require("lsp_lines").toggle() -- start disabled
		end,
	},
}
