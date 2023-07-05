local M = {}

-- ASM
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local cmd = "cargo asm --lib --native"

local function get_results()
	local output = vim.fn.systemlist(cmd)
	-- remove non result text
	table.remove(output, 1)
	table.remove(output, 1)
	table.remove(output, 1)

	-- return output

	local formatted_output = {}
	-- table.insert(formatted_output, { "hello", "world" })
	local regex_expr = '(.*) "(.*)" (.*)$'
	for _, entry in ipairs(output) do
		local idx, func, loc = entry:match(regex_expr)
		local formatted_entry = { idx, func, loc }
		table.insert(formatted_output, formatted_entry)
	end
	return formatted_output
end

-- our picker function: asm
local asm = function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Function Name",
			finder = finders.new_table({
				results = get_results(),
				entry_maker = function(entry)
					return {
						-- value = string.match(entry[1], "^%s*(.-)$0"),
						value = entry[1],
						display = string.format("%6s %s", entry[3], entry[2]),
						ordinal = entry[2],
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd("term " .. "cargo asm --lib " .. selection.value .. " --rust --native --simplify")
					vim.api.nvim_buf_set_name(0, selection.ordinal)
				end)
				return true
			end,
		})
		:find()
end

M.asm = function()
	local theme = require("user.extensions.telescope").minimal_theme()
	asm(theme)
end

-- MINIMAL THEME
M.minimal_theme = function()
	return require("telescope.themes").get_dropdown({
		borderchars = {
			{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
			preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
		width = 0.6,
		previewer = false,
		prompt_title = false,
	})
end

--
return M
