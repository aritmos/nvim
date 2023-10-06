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
        tag = "0.1.1",
        dependencies = {
            "nvim-telescope/telescope-fzy-native.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>ff",
                ':lua require("telescope.builtin").find_files(require("user.extensions.telescope").minimal_theme())<CR>',
                { desc = "Telescope: Find Files" },
            },
            { "<leader>fe", "<cmd>Telescope file_browser<CR>",           desc = "Telescope: Explorer" },
            { "<leader>fk", "<cmd>Telescope keymaps<CR>",                desc = "Telescope: Keymaps" },
            { "<leader>fb", "<cmd>Telescope buffers theme=dropdown<CR>", desc = "Telescope: Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>",              desc = "Telescope: Help Tags" },
            { "<leader>fd", "<cmd>Telescope diagnostics<CR>",            desc = "Telescope: Diagnostics" },
            { "<leader>/",  "<cmd>Telescope live_grep<CR>",              desc = "Telescope: Grep" },
            {
                "<leader>,",
                "<cmd>lua vim.cmd('cd ' .. vim.fn.stdpath('config'))<CR>"
                .. "<CMD>lua require('telescope.builtin').find_files(require('user.extensions.telescope').minimal_theme())<CR>",
                desc = "Open Config",
            },

            -- Treesitter menus: (for use in Rust)
            {
                "<leader>tt",
                "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>",
                desc = "Telescope: Treesitter",
            },
            {
                "<leader>tf",
                "<CMD>lua require('telescope.builtin').lsp_document_symbols({symbols = {'function'}})<CR>",
                desc = "Telescope: Treesitter Functions",
            },
            {
                "<leader>ti",
                "<CMD>lua require('telescope.builtin').lsp_document_symbols({symbols = {'object'}})<CR>",
                desc = "Telescope: Treesitter Implementations",
            },
            {
                "<leader>ts",
                "<CMD>lua require('telescope.builtin').lsp_document_symbols({symbols = {'struct', 'enum'}})<CR>",
                desc = "Telescope: Treesitter Structs/Enums",
            },
            {
                "<leader>ta",
                "<CMD>lua require('user.extensions.telescope').asm()<CR>",
                desc = "Telescope: Assembly",
            },
        },
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
