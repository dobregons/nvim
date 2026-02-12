-- Set the leader key to space
vim.g.mapleader = " "
-- Set the default git editor to nvim
vim.env.GIT_EDITOR = "nvim"
-- Set enable line numbers and relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enables persistent undo, allowing you to keep undo
-- history for files even after closing and reopening them
vim.opt.undofile = true

-- Improved window-splitting behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tab config
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0 -- set to 0 to default to tabstop value
vim.opt.autoindent = true

-- Enable soft wrapping
vim.opt.wrap = true

-- Nicer wrapping (break at words, not characters)
vim.opt.linebreak = true

-- enable copy from neovim to somewhere else
vim.opt.clipboard:append("unnamedplus")

-- consider - as part of the word
vim.opt.iskeyword:append("-")

-- enables 24-bit true color in terminal Vim/Neovim
vim.opt.termguicolors = true
-- Always shows the sign column, preventing text shifting
vim.opt.signcolumn = "yes"

-- indent
-- Allows Backspace to delete auto-indentation (spaces or tabs added by Vim).
-- eol
-- Allows Backspace to delete the newline character, so you can join the current line with the previous one.
-- start
-- Allows Backspace to delete characters before where you entered Insert mode.
vim.opt.backspace = "indent,eol,start"

-- search settings
vim.opt.ignorecase = true
-- smart case
vim.opt.smartcase = true
-- make indenting smarter again
vim.opt.smartindent = true

-- Creates a swap file
vim.opt.swapfile = false

-- opt.iskeyword:append("-") -- consider - as part of the word

-- Folding
vim.opt.foldmethod = "indent" -- or "expr" for treesitter-based folding
vim.opt.foldlevel = 99 -- start with all folds open

-- Timeout settings for key mappings
-- vim.opt.timeoutlen = 1000 -- Time in ms to wait for a mapped sequence to complete (default 1000)
-- vim.opt.ttimeoutlen = 50 -- Time in ms to wait for a key code sequence to complete
