local status, lualine = pcall(require, "lualine")
if not status then
    print("Lualine is not installed")
    return
end

lualine.setup({
    options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "diagnostics",
                sources = { "nvim_lsp", "nvim_diagnostic" },
                sections = { "error", "warn" },
                symbols = { error = "E: ", warn = "W: " },
                always_visible = false,
            },
        },
        lualine_c = {
            "filename",
            "lsp_progress",
        },
        lualine_x = {
            "diff",
            { "branch", icon = "" },
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
