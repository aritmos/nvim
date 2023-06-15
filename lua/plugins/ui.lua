return {
	{
		"rose-pine/nvim",
		name = "rose-pine",
		priority = 1000,
		lazy = false,
		config = function()
			require("user.core.colorscheme")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		-- dependencies = {
		-- 	"arkav/lualine-lsp-progress",
		-- },
		config = function()
			require("user.config.lualine")
		end,
	},
	-- {
	-- 	"startup-nvim/startup.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("user.config.startup")
	-- 	end,
	-- },
}
