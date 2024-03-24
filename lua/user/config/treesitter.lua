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
        "c",
        "cpp",
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


    -- treesitter textobjects
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                -- in Rust `class` includes: struct, enum, trait, impl, ...
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            },
            -- selection_modes = {
            --     ['@parameter.outer'] = 'v', -- charwise
            --     ['@function.outer'] = 'V',  -- linewise
            --     ['@class.outer'] = 'V',     -- linewise
            -- },
            include_surrounding_whitespace = false,
        },
    },
})

-- add highlighting to comments in rust to differentiate them from inlay hints
vim.api.nvim_set_hl(0, "@comment", { link = "SagaBorder" })
