-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
    return
end

saga.setup({
    ui = {
        title = false,
        code_action = "A", -- change lightbulb
        border = "solid",
    },
    hover = {
        max_width = 0.5,
        open_link = "gl",
    },
    lightbulb = { -- "lightbulb" in gutter only
        enable = true,
        sign = true,
        sign_priority = 40,
        virtual_text = false,
    },
    diagnostic = {
        -- show_code_action = false,
        max_show_width = 0.8
    },
})
