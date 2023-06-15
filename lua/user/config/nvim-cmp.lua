local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	print("Cmp not installed")
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	print("Luasnip not installed")
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load friendly snippets
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<Up>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<Down>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
	}),
	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 30,
			ellipsis_char = "...",
			-- before = function(entry, vim_item)
			-- 	vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
			-- 	return vim_item
			-- end,
		}),
	},
})
