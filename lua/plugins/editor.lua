-- editor related plugins

local codefiles = require("user.config.code-files").file_types

return {
    {
        "nvim-tree/nvim-tree.lua",
        event = "VeryLazy",
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree: Toggle" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("user.config.nvim-tree")
        end,
    },
    {
        "stevearc/oil.nvim",
        keys = {
            { "<leader>po", "<CMD>Oil<CR>", desc = "Oil: Open parent directory in buffer" },
        },
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "folke/zen-mode.nvim",
        keys = {
            { "<leader>pz", "<cmd>ZenMode<CR>", desc = "Zen mode" },
        },
        opts = {
            window = {
                backdrop = 0.8,
                width = 0.7,
            },
            plugins = {
                options = {
                    wrap = false -- disable line wrap
                }
            }
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = {
            "nvim-telescope/telescope-fzy-native.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-lua/plenary.nvim",
        },
        keys = require("user.config.keymaps").telescope,
        config = function()
            require("user.config.telescope")
        end,
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        config = true,
        keys = {
            { "s", "<Plug>(leap-forward-to)",  "Leap: Forward" },
            { "S", "<Plug>(leap-backward-to)", "Leap: Backward" },
        },
    },
    {
        "ggandor/flit.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "thePrimeagen/harpoon",
        ft = codefiles,
        keys = {
            { "<leader>he", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon: Edit" },
            { "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>",        "Harpoon: Add File" },
            { "<leader>1",  ":lua require('harpoon.ui').nav_file(1)<CR>",         "Harpoon: Goto 1" },
            { "<leader>2",  ":lua require('harpoon.ui').nav_file(2)<CR>",         "Harpoon: Goto 2" },
            { "<leader>3",  ":lua require('harpoon.ui').nav_file(3)<CR>",         "Harpoon: Goto 3" },
            { "<leader>4",  ":lua require('harpoon.ui').nav_file(4)<CR>",         "Harpoon: Goto 4" },
        },
        opts = {
            tabline = true,
            menu = {
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            },
        },
    },
}
