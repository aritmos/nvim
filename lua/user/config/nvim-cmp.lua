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

-- load friendly snippets (magically finds installed snippet extensions)
require("luasnip/loaders/from_vscode").lazy_load()
-- load snippet extensions
require("luasnip/loaders/from_vscode").load_standalone({ path = "./lua/user/extensions/e.code-snippets" })

vim.opt.completeopt = "menu,menuone,noselect"

-- used within the supertab setup in nvim-cmp
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- configure nvim-cmp
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        -- autocompletes if menu is available
        -- if it is within a snippet expand/jump it does that
        -- else behaves as a normal <Tab>
        ["<Tab>"] = function(fallback)
            if cmp.visible() then          -- selects element in completion menu
                cmp.confirm({ select = true })
            elseif has_words_before() then -- completes words and such
                cmp.complete()
            else                           -- behave like a normal <Tab>
                fallback()
            end
        end,

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then -- expands/jumps within snippets
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<Up>"] = cmp.mapping.select_prev_item(),   -- previous suggestion
        ["<Down>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-Space>"] = cmp.mapping.complete(),      -- show completion suggestions
    },
    -- sources for autocompletion
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp
        { name = "luasnip" },  -- snippets
        { name = "buffer" },   -- text within current buffer
        { name = "path" },     -- file system paths
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
