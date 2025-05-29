
-- Theme
vim.o.background = 'dark'
vim.cmd.colorscheme 'miss-dracula'

-- General
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.encoding = "UTF-8"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.wo.scrolloff = 20

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- SpellChecker
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"



