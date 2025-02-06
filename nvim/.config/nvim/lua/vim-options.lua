-- vim.cmd("set expandtab")
-- vim.cmd("set tabstop=2")
-- vim.cmd("set softtabstop=2")
-- vim.cmd("set shiftwidth=2")

-- vim.opt.showtabline = 0 -- Always show tabs
vim.opt.tabstop = 4 -- Insert 2 spaces for a tab
vim.opt.softtabstop = 4 -- Number of spaces tabs count for while editing
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.expandtab = false -- convert tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.background = "light"
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.opt.swapfile = false
--line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = " " }
-- Enable break indent
vim.opt.breakindent = true

vim.opt.wrap = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- character line width
-- vim.opt.colorcolumn = "80"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.winblend = 0
vim.opt.pumblend = 0

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- copy into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- move up/down selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- vim.wo.number = true

-- custom undo, swp and backup folder
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false
-- vim.opt.undodir = { prefix .. "/nvim/.undo//" }

-- Show which line your cursor is on
-- vim.opt.cursorline = true
-- change cursor block
vim.opt.guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

vim.opt.clipboard = "unnamedplus"

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostics
vim.g["diagnostics_active"] = true
function Toggle_diagnostics()
	if vim.g.diagnostics_active then
		vim.g.diagnostics_active = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_active = true
		vim.diagnostic.enable()
	end
end

vim.keymap.set(
	"n",
	"<leader>xd",
	Toggle_diagnostics,
	{ noremap = true, silent = true, desc = "Toggle vim diagnostics" }
)
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float())
-- vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.keymap.set(
	"n",
	"<leader>e",
	":lua vim.diagnostic.open_float(nil, { focusable = true })<CR>",
	{ noremap = true, silent = true }
)
