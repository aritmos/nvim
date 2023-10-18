-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

-- configure treesitter
treesitter.setup({
    -- enable syntax highlighting
    highlight = {
        enable = true,
    },
    -- enable indentation
    indent = { enable = true, disable = { "python" } }, --python indenting is currently broken
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = { enable = true },
    -- ensure these language parsers are installed
    ensure_installed = {
        "lua",
        "rust",
        "python",
        "toml",
        "markdown",
        "markdown_inline",
        "kdl",
        "zig",
    },
    -- auto install above language parsers
    auto_install = true,
})

-- adds background to differentiate it from inlay hints
vim.api.nvim_set_hl(0, "@comment.rust", { link = "SagaBorder" })

-- Treesitter textobjects
require("nvim-treesitter.configs").setup({
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer", -- in Rust class includes: struct, enum, trait, impl, ...
                ["ic"] = "@class.inner",
            },
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V',  -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
        },
    },
})
