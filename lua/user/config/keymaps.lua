local M = {}

M.telescope = {
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
        "<cmd>lua vim.cmd('cd ' .. vim.fn.stdpath('config'))<CR>",
        -- .. "<CMD>lua require('telescope.builtin').find_files(require('user.extensions.telescope').minimal_theme())<CR>",
        desc = "Goto Config",
    },

    -- Treesitter menus: (for use in Rust)
    {
        "<leader>tt",
        "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>",
        desc = "[T]elescope: [T]reesitter",
    },
    {
        "<leader>tf",
        "<CMD>lua require('telescope.builtin').lsp_document_symbols({symbols = {'function'}})<CR>",
        desc = "(Telescope) [T]reesitter [F]unctions",
    },
    {
        "<leader>ti",
        "<CMD>lua require('telescope.builtin').lsp_document_symbols({symbols = {'object'}})<CR>",
        desc = "(Telescope) [T]reesitter [I]mplementations",
    },
    {
        "<leader>ts",
        "<CMD>lua require('telescope.builtin').lsp_document_symbols({symbols = {'struct', 'enum'}})<CR>",
        desc = "(Telescope) [T]reesitter [S]tructs/Enums",
    },
    {
        "<leader>ta",
        "<CMD>lua require('user.extensions.telescope').asm()<CR>",
        desc = "[T]elescope: [A]ssembly",
    },

}

M.dap = {
    { "<leader>Db", "<cmd>DapToggleBreakpoint<CR>",               desc = "Toggle [b]reakpoint" },
    { "<leader>Dh", ":lua require('dap.ui.widgets').hover()<CR>", desc = "[D]ebug [h]over" }
}

M.dap_go = {
    {
        "<leader>Dgt",
        function()
            require("dap-go").debug_test()
        end,
        desc = "[D]ebug [G]o [t]est"
    },
    {
        "<leader>Dgl",
        function()
            require("dap-go").debug_last()
        end,
        desc = "[D]ebug [G]o: [l]ast test"
    }
}

M.dap_ui = {
    { "<leader>Du", ":lua require('dapui').toggle()<CR>", desc = "Toggle [D]ebugger [U]I" }
}

return M
