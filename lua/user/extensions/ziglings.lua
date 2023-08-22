-- `:Ziglings` command to test the ziglings exercise open in the current buffer

local M = {}

local function zellij_build_current()
    local buffer_name = vim.fn.expand("%:t")
    local ex_num = string.sub(buffer_name, 1, 3)

    local zsh_command = "zig build -Dn=" .. ex_num
    local zellij_command = "zellij run -f -n 'EX: " .. ex_num .. "' -- " .. zsh_command

    vim.fn.system(zellij_command)
end

M.zellij_build_current = zellij_build_current

return M
