-- treesitter related plugins

return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            -- includes config for `nvim-treesitter-textobjects`
            require("user.config.treesitter")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        -- config managed by `nvim-treesitter`
    }
}
