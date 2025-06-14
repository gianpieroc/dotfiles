local km = vim.keymap

-- Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath
    }
end

require 'settings'
require 'keymaps'

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
    {import = 'plugins'}, {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {theme = 'gruvbox'},
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {
                        {'filename'}, {
                            'diagnostics',
                            sources = {'nvim_diagnostic'},
                            sections = {'error', 'warn', 'info', 'hint'},
                            symbols = {
                                error = ' ',
                                warn = ' ',
                                info = ' '
                            },
                            colored = true,
                            update_in_insert = false
                        }
                    },
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                }
            }
        end
    }, {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }, {
        'm4xshen/smartcolumn.nvim',
        config = function()
            local smartcolumn_config = {
                colorcolumn = '120',
                disabled_filetypes = {'help', 'text', 'markdown'},
                custom_colorcolumn = {},
                scope = 'line'
            }

            require('smartcolumn').setup(smartcolumn_config)
        end
    }, {
        'mbbill/undotree',
        config = function()

            km.set('n', '<Leader>u', vim.cmd.UndotreeToggle)
        end
    }, 'echasnovski/mini.icons', 'lewis6991/gitsigns.nvim'
}

