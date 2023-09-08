local codefiles = require("user.config.code-files").file_types

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
            "simrat39/rust-tools.nvim",          -- config dependency
            "hrsh7th/cmp-nvim-lsp",              -- config dependency
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim", -- server dependency
        },
        -- keybinds defined within config file (below)
        config = function()
            require("user.config.lsp.lspconfig")
        end,
    },
    {
        "Canop/nvim-bacon",
        ft = "rust",
        keys = {
            { "<leader>bd", ":BaconList<CR>", desc = { "Bacon: Display" } },
            { "<leader>br", ":BaconLoad<CR>", desc = { "Bacon: Load" } },
            { "<leader>bn", ":BaconNext<CR>", desc = { "Bacon: Next" } },
        },
    },
    {
        "nvimdev/lspsaga.nvim",
        ft = codefiles,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
        config = function()
            require("user.config.lsp.lspsaga")
        end,
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy", -- use legacy tag while plugin gets rewritten (12/06/23)
        ft = codefiles,
        config = function()
            require("fidget").setup({
                text = { spinner = "dots" },
                fmt = { max_width = 40 },
            })
        end,
    },
}
