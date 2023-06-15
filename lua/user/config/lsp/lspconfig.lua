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

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local function opts(desc)
		return { desc = "LSP: " .. desc, noremap = true, silent = true, buffer = bufnr }
	end

	-- set keybinds
	keymap.set("n", "<leader>vi", "<cmd>Lspsaga lsp_finder<CR>", opts("View Info")) -- show definition, references
	keymap.set("n", "<leader>vh", "<cmd>Lspsaga hover_doc<CR>", opts("View Hover")) -- show diagnostics for cursor
	keymap.set("n", "<leader>vD", "<cmd>Lspsaga hover_doc<CR>", opts("View Documentation"))

	keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts("Goto Declaration")) -- got to declaration
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts("Goto Implementation")) -- go to implementation

	keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts("Code Action")) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts("Rename")) -- smart rename

	-- use native diagnostics
	keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts("Diagnostic")) -- show diagnostics for cursor
	keymap.set("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts("Previous Diagnostic"))
	keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts("Next Diagnostic"))
end

require("user.core.diagnostics") -- use default vim diagnostic windows

-- custom inlay diagnostic prefix
-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		prefix = "«",
-- 	},
-- })

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
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

lspconfig["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- configure rust-tools (with special settings)
local status, rt = pcall(require, "rust-tools")
if not status then
	print("Rust-tools not installed")
	return
end

rt.setup({
	tools = {
		inlay_hints = {
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "~ ",
			highlight = "Comment",
		},
	},
	server = {
		capabilities = capabilities,
		on_attach = function(_, bufnr)
			-- default actions
			on_attach(_, bufnr)
			-- keymaps
			-- vim.keymap.set("n", "vh", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
})

rt.inlay_hints.enable()

lspconfig["zls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
