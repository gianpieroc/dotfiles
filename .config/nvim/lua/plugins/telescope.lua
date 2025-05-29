return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'natecraddock/telescope-zf-native.nvim',
    },
    config = function()
        -- Initialize Telescope and its extensions.
        local builtin = require 'telescope.builtin'
        local telescope = require 'telescope'
        local live_grep_args_shortcuts = require 'telescope-live-grep-args.shortcuts'
        local noice = require 'noice'
        local km = vim.keymap

        telescope.setup {
            -- Add any custom configuration here
            defaults = { file_ignore_patterns = { 'node_modules', '.git/' } },
        }

        -- Load Extensions
        telescope.load_extension 'file_browser'
        telescope.load_extension 'live_grep_args'
        telescope.load_extension 'zf-native'
        telescope.load_extension 'notify'

        -- Setup Keymaps
        km.set('n', '<C-p>', builtin.find_files, {})
        km.set('n', '<leader>bl', builtin.buffers, {})
        km.set('n', '<leader>pf', builtin.git_files, {})
        km.set('n', '<leader>fo', builtin.oldfiles, {})
        km.set('n', '<leader>pg', builtin.git_status, {})
        km.set('n', '<leader>pt', ':Telescope file_browser<CR>', {})
        km.set('n', '<leader>pn', ':Telescope notify<CR>', {})
        km.set('n', '<leader>/', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        km.set('n', '<leader>pV', live_grep_args_shortcuts.grep_visual_selection)
    end,
}
