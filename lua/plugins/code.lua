-- code related plugins

local codefiles = require("user.config.code-files").file_types

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
    -- quality of life
    {
        "kylechui/nvim-surround",
        event = "BufReadPre",
        config = true,
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
            require("mini.comment").setup({})
        end,
    },
    {
        "mfussenegger/nvim-dap",
        ft = codefiles,
        keys = require("user.config.keymaps").dap,
    },
    {
        "rcarriga/nvim-dap-ui",
        ft = codefiles,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("user.config.dapui")
        end,
        keys = require("user.config.keymaps").dap_ui,
    },
    -- git
    {
        "lewis6991/gitsigns.nvim",
        ft = codefiles,
        opts = {
            attach_to_untracked = true,
        }
    },
}
