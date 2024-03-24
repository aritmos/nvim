-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end


-- -------------------
-- | GLOBAL KEYBINDS |
-- -------------------

local keymap = vim.keymap -- for conciseness

local keymaps = function(client, bufnr)
    -- keybind options
    local function opts(desc)
        return { desc = "LSP: " .. desc, noremap = true, silent = true, buffer = bufnr }
    end

    -- set keybinds
    keymap.set("n", "<leader>vi", "<cmd>Lspsaga finder<CR>", opts("View Info"))                    -- show definition, references
    keymap.set("n", "<leader>vh", "<cmd>Lspsaga hover_doc<CR>", opts("View Hover"))                -- show diagnostics for cursor
    keymap.set("n", "<leader>vH", "<cmd>Lspsaga hover_doc ++keep<CR>", opts("View Hover and Pin")) -- show diagnostics for cursor
    keymap.set("n", "<leader>vD", "<cmd>Lspsaga hover_doc<CR>", opts("View Documentation"))

    keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts("Goto Declaration"))
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts("Goto Implementation"))

    keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts("Code Action"))
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts("Rename"))

    -- use native diagnostics
    keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts("Diagnostic"))
    -- keymap.set("n", "<leader>D", "<cmd>Lspsaga show_workspace_diagnostics ++normal<CR>", opts("Workspace Diagnostics"))
    keymap.set("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts("Previous Diagnostic"))
    keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts("Next Diagnostic"))
end


-- ---------------
-- | DIAGNOSTICS |
-- ---------------

-- use default vim diagnostic windows
require("user.core.diagnostics")

-- ------------------
-- | FORMAT ON SAVE |
-- ------------------

local code_file_exts = require("user.config.code-files").file_exts
local exts = ""
for _, ext in ipairs(code_file_exts) do
    exts = exts .. "*." .. ext .. ","
end
exts = exts:sub(1, -2) -- remove the trailing comma
vim.api.nvim_command("autocmd BufWritePre " .. exts .. " lua vim.lsp.buf.format()")


-- ------------------
-- | AUTOCOMPLETION |
-- ------------------

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()


-- ---------------
-- | INLAY HINTS |
-- ---------------

if vim.version().minor >= 10 then
    vim.lsp.inlay_hint.enable()
end

local lsp_inlayhints = require("lsp-inlayhints")
lsp_inlayhints.setup({
    inlay_hints = {
        type_hints = {
            prefix = "~ ",
            remove_colon_start = true,
        }
    }
})

vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })

vim.api.nvim_create_user_command(
    'InlayHintsToggle',
    function()
        require("lsp-inlayhints").toggle()
    end,
    {}
)

-- -------------
-- | ON ATTACH |
-- -------------

local on_attach = function(client, bufnr)
    -- register keymaps
    keymaps(client, bufnr)
    -- this is not automatically loading for some reason
    require("lsp-inlayhints").on_attach(client, bufnr)
    -- require("lsp-inlayhints").show()
end

-- ------------------------
-- | SERVER CONFIGURATION |
-- ------------------------

-- configure lua server (with special settings)
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})


-- configure python
lspconfig.pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- configure rust (rustaceanvim)
-- https://github.com/mrcjkb/rustaceanvim/blob/master/doc/rustaceanvim.txt

vim.g.rustaceanvim = {
    tools = {
        inlay_hints = {
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "~ ",
            highlight = "Comment",
        },
    },
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = true,
                check = {
                    command = "clippy",
                    features = "all",
                },
            },
        },
    },
}

-- Zig
local zig_on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    -- Ziglings
    local fn = "require('user.extensions.ziglings').zellij_build_current()"
    vim.cmd("command! Ziglings lua " .. fn)
    -- for now we automatically register the keybind to run `:Ziglings`
    -- later when I finish Ziglings we can remove it.
    -- TODO: see if there's some way to only load this if we are in the ziglings folder (?)
    vim.api.nvim_set_keymap("n", "<leader><S-z>", "<CMD>Ziglings<CR>",
        { noremap = true, silent = true, desc = "Ziglings Build Current" })
end

lspconfig.zls.setup({
    capabilities = capabilities,
    on_attach = zig_on_attach,
})


-- Go
local util = require "lspconfig/util"

lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            }
        }
    }
})

-- C/C++

lspconfig.clangd.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    filetypes = { "c", "cpp" },
})
-- lspconfig.clangd_format.setup({
--     on_attach = on_attach,
--     capabilities = capabilities
-- })
