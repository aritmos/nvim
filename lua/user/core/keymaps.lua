vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- for `silent' use: opts = { silent = true }

-- INSERT MODE --

map("i", "jj", "<ESC>")

-- NORMAL MODE --

-- movement
map("n", "J", "<C-d>zz", { desc = "Goto Half Page Down" })
map("n", "K", "<C-u>zz", { desc = "Goto Half Page Up" })
map("n", "H", "^", { desc = "Goto Line Start" })
map("n", "L", "$", { desc = "Goto Line End" })
map("n", "<leader><up>", "<C-i>", { desc = "Jump Forward" })
map("n", "<leader><down>", "<C-o>", { desc = "Jump Back" })

-- add lines
map("n", "<leader>o", "o<ESC>")
map("n", "<leader>O", "O<ESC>")

-- join lines
map("n", "<leader>J", "J")

-- buffers
map("n", "<leader>w", ":up<CR>", { silent = true })
map("n", "<leader>q", ":bd<CR>", { silent = true })
map("n", "<leader>x", ":q!<CR>")

-- yank and paste
map("n", "Y", "y$")
map("n", "<leader>y", "gg<S-v>Gy", { desc = "Yank File" })
map("n", "<C-p>", '"0p', { desc = "Paste Yanked" })
map("n", "<C-P>", '"0P', { desc = "Paste Yanked (Above)" })

-- redo
map("n", "U", "<C-R>", { desc = "Redo" })

-- visual mode indenting
map("v", "<", "<gv", { desc = "Indent" })
map("v", ">", ">gv", { desc = "Unindent" })

-- windows splits
-- map("n", "<leader>sv", "<C-w>v", { desc = "Split: Vertical" })
-- map("n", "<leader>sh", "<C-w>s", { desc = "Split: Horizontal" })
-- map("n", "<leader>se", "<C-w>=", { desc = "Split: Make Equal" })
-- map("n", "<leader>sx", ":close<CR>", { desc = "Split: Close" })

map("n", "<up>", ":wincmd k<CR>", { desc = "Goto: Split Up" })
map("n", "<down>", ":wincmd j<CR>", { desc = "Goto: Split Down" })
map("n", "<left>", ":wincmd h<CR>", { desc = "Goto: Split Left" })
map("n", "<right>", ":wincmd l<CR>", { desc = "Goto: Split Right" })

-- tabs
map("n", "<leader>to", ":tabnew<CR>", { desc = "Tab: New" })
map("n", "<leader>tx", ":tabclose<CR>", { desc = "Tab: Close" })
map("n", "<leader>tk", ":tabn<CR>", { desc = "Tab: Next" })
map("n", "<leader>tj", ":tabp<CR>", { desc = "Tab: Prev" })

-- misc
map("n", "<leader>nh", ":nohl<CR>", { desc = "Remove Highlight" })
map("n", "x", '"_x') -- dont delete text into register

-- PLUGINS --
map("n", "<leader>pl", ":Lazy<CR>", { desc = "Plugins: Lazy" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape Terminal" })

function minimal()
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

map(
	"n",
	"<leader>ff",
	':lua require("telescope.builtin").find_files(minimal())<CR>',
	{ desc = "Telescope: Find Files" }
)

-- ACTIONS

-- Ziglings
-- function ziglings()
-- 	-- Get the filename of the current buffer
-- 	local filename = vim.fn.expand("%:t")
--
-- 	-- Extract the first 3 digits from the filename
-- 	local number = string.match(filename, "%d%d%d")
--
-- 	-- Build the Zig file using the extracted number
-- 	local command = "zellij run -f -- zig build -Dn=" .. number
-- 	os.execute(command)
-- end

-- map("n", "<leader>z", ":lua ziglings()<CR>", { desc = "Verify current zigling file" })
