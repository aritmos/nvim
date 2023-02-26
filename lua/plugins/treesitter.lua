return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("user.config.treesitter")
		end,
	},
}
