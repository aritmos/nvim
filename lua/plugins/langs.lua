-- language specific plugins

return {
    -- go
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            require("go").setup()
        end,
        ft = { "go", "gomod" },
    },
    {
        "leoluz/nvim-dap-go",
        ft = { "go" },
        dependencies = {
            "mfussenegger/nvim-dap"
        },
        keys = require("user.config.keymaps").dap_go,
        config = function(_, opts)
            require("dap-go").setup(opts)
        end
    },
    -- rust
    {
        "Canop/nvim-bacon",
        ft = "rust",
        keys = {
            { "<leader>bd", ":BaconList<CR>", desc = { "Bacon: Display" } },
            { "<leader>br", ":BaconLoad<CR>", desc = { "Bacon: Load" } },
            { "<leader>bn", ":BaconNext<CR>", desc = { "Bacon: Next" } },
        },
    },
}
