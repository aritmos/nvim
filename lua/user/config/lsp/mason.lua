-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"pylsp",
		"pyright",
		"rust_analyzer",
		"lua_ls",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"autopep8",
		"stylua",
		-- "rustfmt", -- for some reason installing rustfmt here breaks the autoformatting that it should provide
		-- im guessing that it instead uses the rustup version which appears to work. in the future
		-- uncomment it and see if the null_ls version works
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
