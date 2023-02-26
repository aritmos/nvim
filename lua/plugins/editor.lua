return {
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("user.config.nvim-tree")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = {
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope: Files" },
			{ "<leader>fe", "<cmd>Telescope file_browser<CR>", desc = "Telescope: Explorer" },
			{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Telescope: Keymaps" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope: Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope: Help Tags" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Telescope: Diagnostics" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Telescope: Document Symbols" },
			{ "<leader>ft", "<cmd>Telescope treesitter<CR>", desc = "Telescope: Treesitter" },
			{ "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Telescope: Grep" },
			{
				"<leader>,",
				"<cmd>cd C:Users\\Sebastian\\Appdata\\Local\\nvim | Telescope find_files<CR>",
				desc = "Open Config",
			},
		},
		config = function()
			require("user.config.telescope")
		end,
	},
	{
		"ggandor/leap.nvim",
		event = "BufReadPre",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"ggandor/flit.nvim",
		event = "BufReadPre",
		config = true,
	},
}
