local status, lualine = pcall(require, "lualine")
if not status then
	print("Lualine is not installed")
	return
end

local function get_named_open_buffer_count()
	local bufinfo = vim.fn.getbufinfo({ buflisted = 1 })
	local count = 0
	for _, buf in ipairs(bufinfo) do
		if buf.name ~= "" then
			count = count + 1
		end
	end
	return "B: " .. count
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
			-- { get_named_open_buffer_count, color = "lualine_b_normal" },
			"filename",
			"lsp_progress",
		},
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
