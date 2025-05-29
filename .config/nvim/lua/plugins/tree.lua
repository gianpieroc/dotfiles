return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local km = vim.keymap
        require('nvim-tree').setup {

            km.set('n', '<Leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true }),
        }
    end,
}
