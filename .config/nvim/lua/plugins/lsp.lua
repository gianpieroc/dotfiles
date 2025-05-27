return {

    {'williamboman/mason.nvim', "williamboman/mason-lspconfig.nvim"},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'}, {
        "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = {"mason-lspconfig.nvim", "nlsp-settings.nvim"},
        config = function()
            local km = vim.keymap
            local lsp = require('lsp-zero')
            lsp.extend_lspconfig()

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({buffer = bufnr})
            end)

            local cmp = require('cmp')
            local cmp_format = require('lsp-zero').cmp_format()
            cmp.setup({formatting = cmp_format})

            require('mason').setup()

            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls", "pyright", "ts_ls", "eslint", "tailwindcss",
                    "emmet_language_server", "jsonls"
                },
                handlers = {lsp.default_setup}
            })
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls({
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                            -- Set workspace to only include your Neovim config directory
                            library = {
                                vim.env.VIMRUNTIME, "${3rd}/luv/library",
                                "${3rd}/busted/library",
                                vim.fn.stdpath("config")
                            }
                        },
                        diagnostics = {globals = {'vim'}},
                        telemetry = {enable = false}
                    }
                }
            }))

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({buffer = bufnr})

                km.set("n", "<leader>la",
                       function() vim.lsp.buf.code_action() end)
                km.set("n", "<leader>lf", function()
                    vim.lsp.buf.format()
                end)
                km.set("n", "<leader>lo",
                       function() vim.lsp.buf.open_float() end)
                km.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end)
                km.set("n", "gD", function()
                    vim.lsp.buf.declaration()
                end)
                km.set("n", "gI", function()
                    vim.lsp.buf.implementation()
                end)
                km.set("n", "go", function()
                    vim.lsp.buf.type_definition()
                end)
                km.set("n", "gr", function()
                    vim.lsp.buf.references()
                end)
            end)

            cmp.setup({
                mapping = {
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({
                                    behavior = cmp.SelectBehavior.Select
                                })
                            else
                                cmp.confirm()
                            end
                        else
                            fallback()
                        end
                    end, {"i", "s", "c"}),
                    ['<S-Tab>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item({
                                behavior = cmp.SelectBehavior.Select
                            })
                        end
                    end, {"i", "s", "c"})
                }
            })

            lsp.setup()

            -- keymaps 

            -- Format
            km.set('n', '<C-§>', ':lua vim.lsp.buf.format()<CR>',
                   {noremap = true, silent = true})
        end

    }, {"tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true},
    {'hrsh7th/cmp-nvim-lsp'}, {'L3MON4D3/LuaSnip'}

}
