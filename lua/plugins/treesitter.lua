return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("user.config.treesitter")
			vim.api.nvim_set_hl(0, "@comment.rust", { link = "SagaBorder" }) -- adds background to differentiate it from inlay hints
		end,
	},
}
