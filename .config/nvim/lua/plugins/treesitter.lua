return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-context',
                opts = {
                    -- Avoid the sticky context from growing a lot.
                    max_lines = 3,
                    -- Match the context lines to the source code.
                    multiline_threshold = 1,
                    -- Disable it when the window is too small.
                    min_window_height = 20,
                },
                keys = {
                    {
                        '[c',
                        function()
                            -- Jump to previous change when in diffview.
                            if vim.wo.diff then
                                return '[c'
                            else
                                vim.schedule(function()
                                    require('treesitter-context').go_to_context()
                                end)
                                return '<Ignore>'
                            end
                        end,
                        desc = 'Jump to upper context',
                        expr = true,
                    },
                },
            },
        },
        version = false,
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'cpp',
                'fish',
                'gitcommit',
                'graphql',
                'html',
                'java',
                'javascript',
                'json',
                'json5',
                'jsonc',
                'lua',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'rasi',
                'regex',
                'rust',
                'scss',
                'toml',
                'tsx',
                'typescript',
                'typescriptreact',
                'vim',
                'vimdoc',
                'yaml',
                'go',
            },
            highlight = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<cr>',
                    node_incremental = '<cr>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },
            indent = {
                enable = true,
                -- Treesitter unindents Yaml lists for some reason.
                disable = { 'yaml' },
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup {
                sync_install = false,
                auto_install = true,
                highlight = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['ii'] = '@conditional.inner',
                            ['ai'] = '@conditional.outer',
                            ['il'] = '@loop.inner',
                            ['al'] = '@loop.outer',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']f'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']F'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[f'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[F'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = { ['<leader>pan'] = '@parameter.inner' },
                        swap_previous = { ['<leader>pap'] = '@parameter.inner' },
                     },
                },
            }
        end,
    },
}
