-- lsp related plugins

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
            "lvimuser/lsp-inlayhints.nvim",      -- config dependency
            "mrcjkb/rustaceanvim",               -- config dependency
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
