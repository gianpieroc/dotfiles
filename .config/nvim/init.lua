local km = vim.keymap

-- Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end

require 'settings'
require 'keymaps'

vim.opt.rtp:prepend(lazypath)

local plugins = 'plugins'

require('lazy').setup {
    { import = 'plugins' },
    'nvim-lualine/lualine.nvim',
    'norcalli/nvim-colorizer.lua',
    'm4xshen/smartcolumn.nvim',
    'mbbill/undotree',
    'echasnovski/mini.icons',
    'lewis6991/gitsigns.nvim',
}

-- Colorizer
require('colorizer').setup()

-- lualine
require('lualine').setup { options = { theme = 'gruvbox' } }

-- smart column
local smartcolumn_config = {
    colorcolumn = '120',
    disabled_filetypes = { 'help', 'text', 'markdown' },
    custom_colorcolumn = {},
    scope = 'line',
}

require('smartcolumn').setup(smartcolumn_config)

-- undotree
km.set('n', '<Leader>u', vim.cmd.UndotreeToggle)
