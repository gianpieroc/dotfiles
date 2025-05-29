return {
    'nvimtools/none-ls.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local null_ls = require 'null-ls'

        null_ls.setup {
            sources = {
                -- Prettier for supported filetypes
                null_ls.builtins.formatting.prettier.with {
                    prefer_local = 'node_modules/.bin',
                    condition = function(utils)
                        -- Only use Prettier if a config file is present
                        return utils.root_has_file {
                            '.prettierrc',
                            '.prettierrc.js',
                            '.prettierrc.json',
                            '.prettierrc.yml',
                            '.prettierrc.yaml',
                            'prettier.config.js',
                            'prettier.config.cjs',
                        }
                    end,
                },
                null_ls.builtins.formatting.stylua,
            },
        }

        -- Formatter
        vim.keymap.set('n', '<Leader>f', function()
            vim.lsp.buf.format { async = true }
        end, { desc = 'Format buffer' })
    end,
}
