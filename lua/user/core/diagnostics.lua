local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

sign({ name = "DiagnosticSignError", text = "E" })
sign({ name = "DiagnosticSignWarn", text = "W" })
sign({ name = "DiagnosticSignHint", text = "H" })
sign({ name = "DiagnosticSignInfo", text = "I" })

vim.diagnostic.config({
    virtual_text = false,
    -- virual_lines = { only_current_line = true },
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        border = "solid",
        source = "always",
        header = "",
        prefix = "",
    },
})
