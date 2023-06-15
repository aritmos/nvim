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

-- function Toggle_diagnostic_virtual_lines()
-- 	local config = vim.diagnostic.config()
-- 	if config.virtual_lines == false then
-- 		config.virtual_lines = { only_current_line = true }
-- 	else
-- 		config.virtual_lines = false
-- 	end
-- 	vim.diagnostic.config(config)
-- end
--
