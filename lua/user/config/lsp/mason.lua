-- enable mason
require("mason").setup()

-- install debuggers
require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb", "debugpy" }
})

-- install LSPs
require("mason-lspconfig").setup({
    ensure_installed = {
        "pylsp",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "gopls",
        "clangd",
    },
    -- auto-install configured servers (with lspconfig)
    -- automatic_installation = true, -- not the same as ensure_installed
})
