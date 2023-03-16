require("leap")

-- change from `s` to `<leader>s`
vim.api.nvim_del_keymap("n", "s")
vim.api.nvim_del_keymap("n", "S")
