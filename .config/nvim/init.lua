-- basics
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
local km = vim.keymap


-- LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
    'nvim-lualine/lualine.nvim',
    'norcalli/nvim-colorizer.lua',
    'numToStr/Comment.nvim',
    'Sonicfury/scretch.nvim',
    'm4xshen/smartcolumn.nvim',
    'mbbill/undotree',
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },
    { 'AndreM222/copilot-lualine' },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    -- Fern
    {
        'lambdalisue/fern.vim',
        dependencies = {
            'lambdalisue/fern-hijack.vim',
            'lambdalisue/nerdfont.vim',
            'lambdalisue/fern-renderer-nerdfont.vim',
            'lambdalisue/fern-git-status.vim',
            {
                'yuki-yano/fern-preview.vim',
                keys = {
                    { 'p',     '<Plug>(fern-action-preview:toggle)',           ft = "fern" },
                    { '<C-j>', '<Plug>(fern-action-preview:scroll:down:half)', ft = "fern" },
                    { '<C-k>', '<Plug>(fern-action-preview:scroll:up:half)',   ft = "fern" },
                    { '<C-o>', '<Plug>(fern-action-open:select)',              ft = "fern" },
                    { '<C-v>', '<Plug>(fern-action-open:vsplit)',              ft = "fern" },
                    { 'n',     '<Plug>(fern-action-new-path)',                 ft = "fern" },
                    { 'r',     '<Plug>(fern-action-rename)',                   ft = "fern" },
                    { 'm',     '<Plug>(fern-action-move)',                     ft = "fern" },
                    { 'c',     '<Plug>(fern-action-copy)',                     ft = "fern" },
                    { 't',     '<Plug>(fern-action-remove)',                   ft = "fern" },
                    { ',',     '<Plug>(fern-action-mark:toggle)',              ft = "fern" },
                    { 'd',     '<Plug>(fern-action-diff)',                     ft = "fern" },
                    { 'H',     '<Plug>(fern-action-hidden-toggle)',            ft = "fern" },
                    { 'h',     '<Plug>(fern-action-collapse)',                 ft = "fern" },
                    { '-',     '<Plug>(fern-action-cd)',                       ft = "fern" }
                }
            }
        }
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'natecraddock/telescope-zf-native.nvim'

        },
    },

    --ALE
    {
        'dense-analysis/ale',
        config = function()
            -- Configuration goes here.
            local g = vim.g

            g.ale_ruby_rubocop_auto_correct_all = 1
            g.ale_fixers = { 'prettier' }

            g.ale_linters_aliases = {
                jsx = { 'css', 'javascript' },
                tsx = { 'css', 'javascript' }
            }

            g.ale_linters = {
                ruby = { 'rubocop', 'ruby' },
                lua = { 'lua_language_server' },
                javascript = { 'eslint', 'cspell', 'stylelint' },
                typescript = { 'eslint', 'cspell', 'stylelint' },
                jsx = { 'stylelint', 'eslint' },
                tsx = { 'stylelint', 'eslint' }
            }
        end
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        enabled = true,
        dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
    },

    -- LSP
    { 'williamboman/mason.nvim',         "williamboman/mason-lspconfig.nvim" },
    { 'VonHeikemen/lsp-zero.nvim',       branch = 'v3.x' },
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
    },
    { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },

    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },

    -- Tim Pope
    'tpope/vim-surround',
    'tpope/vim-eunuch',
    'tpope/vim-speeddating',

    -- Folke
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    {
        'folke/trouble.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- modes = {
        --     test = {
        --         mode = "diagnostics",
        --         preview = {
        --         type = "split",
        --         relative = "win",
        --         position = "right",
        --         size = 0.3,
        --         },
        --     },
        -- },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    } })

-- theme
-- Gruvbox initialization
vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- Transparent background because wezterm is already setup with transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- comment
require("Comment").setup({
    toggler = {
        line = '<leader>cl',
        block = '<leader>cb',
    },
    opleader = {
        line = '<leader>cl',
        block = '<leader>cb',
    },
    extra = {
        above = '<leader>cO',
        below = '<leader>co',
        eol = '<leader>cA',
    },
})

-- Autopairs
-- require("lvim.core.autopairs").setup({})


-- Colorizer
require("colorizer").setup()


-- lualine
require('lualine').setup({
    options = { theme = 'gruvbox' }
})

-- notify
local notify = require("notify")

notify.setup({
    background_colour = "#000000",
    fps = 30,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 2,
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 3000,
    top_down = true
})

local wk = require("which-key")
local leader_normal_opts = {
    prefix = "<leader>",
    mode = "n",
    silent = true,
}

local leader_normal_mappings = {
    ["<leader>D"] = { group = "Database" },
    ["<leader>Df"] = { desc = "Find buffer" },
    ["<leader>Dq"] = { desc = "Last query info" },
    ["<leader>Dr"] = { desc = "Rename buffer" },
    ["<leader>Du"] = { desc = "Toggle UI" },
    ["<leader>\\"] = { desc = "Remove highlighting after search" },
    ["<leader>b"] = { group = "buffer" },
    ["<leader>bd"] = { desc = "Close buffer" },
    ["<leader>bl"] = { desc = "List buffers" },
    ["<leader>bn"] = { desc = "Next buffer" },
    ["<leader>bp"] = { desc = "Previous buffer" },
    ["<leader>br"] = { desc = "Refresh buffers (redraw)" },
    ["<leader>bx"] = { desc = "Close all buffers but the current one" },
    ["<leader>c"] = { group = "Comment" },
    ["<leader>cA"] = { desc = "Insert comment at the end of the line" },
    ["<leader>cO"] = { desc = "Insert comment on the line above" },
    ["<leader>cb"] = { desc = "Toggle block comment" },
    ["<leader>cl"] = { desc = "Toggle line comment" },
    ["<leader>co"] = { desc = "Insert comment on the line below" },
    ["<leader>e"] = { group = "NvimTree" },
    ["<leader>ee"] = { desc = "Toggle" },
    ["<leader>ef"] = { desc = "Focus" },
    ["<leader>es"] = { desc = "Show file in tree" },
    ["<leader>f"] = { group = "Find" },
    ["<leader>ff"] = { desc = "Fuzze find file" },
    ["<leader>fo"] = { desc = "Find old file" },
    ["<leader>l"] = { group = "LSP" },
    ["<leader>la"] = { desc = "Code action" },
    ["<leader>lf"] = { desc = "Format" },
    ["<leader>lo"] = { desc = "Open diagnostics float window" },
    ["<leader>mp"] = { desc = "Markdown preview with glow" },
    ["<leader>p"] = { group = "Project" },
    ["<leader>pf"] = { desc = "Search project files (git)" },
    ["<leader>pg"] = { desc = "Project git status" },
    ["<leader>ps"] = { desc = "Live grep" },
    ["<leader>pt"] = { desc = "Telescope explorer" },
    ["<leader>rm"] = { desc = "Remove whitelines" },
    ["<leader>s"] = { group = "Scretch.nvim" },
    ["<leader>sg"] = { desc = "Live grep scretches" },
    ["<leader>sl"] = { desc = "Toggle last scretch" },
    ["<leader>sn"] = { desc = "New scretch" },
    ["<leader>snn"] = { desc = "New named scretch" },
    ["<leader>ss"] = { desc = "Search scretches" },
    ["<leader>sv"] = { desc = "Explore scretches" },
    ["<leader>t"] = { group = "Tabs" },
    ["<leader>tc"] = { desc = "Close" },
    ["<leader>tn"] = { desc = "Next" },
    ["<leader>tp"] = { desc = "Prev" },
    ["<leader>tt"] = { desc = "New" },
    ["<leader>u"] = { desc = "Toggle undotree" },
    ["<leader>w"] = { group = "Window" },
    ["<leader>wc"] = { desc = "Close pane" },
    ["<leader>wh"] = { desc = "Focus left" },
    ["<leader>wj"] = { desc = "Focus down" },
    ["<leader>wk"] = { desc = "Focus up" },
    ["<leader>wl"] = { desc = "Focus right" },
    ["<leader>ws"] = { desc = "Split horizontally" },
    ["<leader>wsj"] = { desc = "Split horizontally and focus down" },
    ["<leader>wv"] = { desc = "Split vertically" },
    ["<leader>wvl"] = { desc = "Split vertically and focus right" },
    ["<leader>ww"] = { desc = "New buffer in new pane" },
    ["<leader>x"] = { group = "Trouble" },
    ["<leader>xR"] = { desc = "Trouble LSP references" },
    ["<leader>xd"] = { desc = "Trouble document diagnostics" },
    ["<leader>xl"] = { desc = "Trouble loclist" },
    ["<leader>xq"] = { desc = "Trouble quickfix" },
    ["<leader>xw"] = { desc = "Trouble workspace diagnostics" },
    ["<leader>xx"] = { desc = "Toggle Trouble" },
}
-- <LEADER> VISUAL MODE
local leader_visual_opts = {
    prefix = "<leader>",
    mode = "v",
    silent = true,
}
local leader_visual_mappings = {
    c = {
        name = "Comment",
        l = "Toggle line comment",
        b = "Toggle block comment",
    },
    ["pV"] = "Live grep visual selection",
}
-- NORMAL MODE
local normal_opts = {
    mode = "n",
    silent = true
}
local normal_mappings = {
    ["[d"] = "Go to next diagnostic",
    ["]d"] = "Go to previous diagnostic",
    z = {
        name = "Folds",
        ["}"] = "Toggle } fold",
        ["{"] = "Toggle { fold",
        [")"] = "Toggle ) fold",
        ["("] = "Toggle ( fold",
        ["]"] = "Toggle ] fold",
        ["["] = "Toggle [ fold",
        ["T"] = "Toggle tag fold",
    },
    g = {
        d = "Go to definition",
        D = "Go to declaration",
        I = "Go to implementation",
        o = "Go to type definition",
        r = "Go to type references",
    }
}

-- CLIPBOARD
vim.opt.clipboard = "unnamedplus"
-- vim.api.nvim_set_option("clipboard", "unnamed")

-- INSERT MODE
local insert_opts = {
    mode = "i",
    silent = true
}
local insert_mappings = {
}
wk.register(leader_normal_mappings, leader_normal_opts)
wk.register(leader_visual_mappings, leader_visual_opts)
wk.register(normal_mappings, normal_opts)
wk.register(insert_mappings, insert_opts)

-- Treesitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "vim", "vimdoc", "query", "rust", "typescript", "javascript", "html", "css" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
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
            swap_next = {
                ['<leader>pan'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>pap'] = '@parameter.inner',
            },
        },
    },
}

-- trouble
require("trouble").setup {}

-- scretch
local scretch = require("scretch")
scretch.setup()

-- lsp
local lsp = require('lsp-zero').preset({
    suggest_lsp_servers = true,
})


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()
cmp.setup({
    formatting = cmp_format,
})

local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)
require('mason').setup()
-- require('mason-lspconfig').extend_lspconfig({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        -- "ruff_lsp",
        "ts_ls",
        "eslint",
        "tailwindcss",
        "emmet_language_server",
        "jsonls",
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    km.set("n", "<leader>la", function() vim.lsp.buf.code_action() end)
    km.set("n", "<leader>lf", function() vim.lsp.buf.format() end)
    km.set("n", "<leader>lo", function() vim.lsp.buf.open_float() end)
    km.set("n", "gd", function() vim.lsp.buf.definition() end)
    km.set("n", "gD", function() vim.lsp.buf.declaration() end)
    km.set("n", "gI", function() vim.lsp.buf.implementation() end)
    km.set("n", "go", function() vim.lsp.buf.type_definition() end)
    km.set("n", "gr", function() vim.lsp.buf.references() end)
end)

cmp.setup({
    mapping = {
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, { "i", "s", "c", }),
        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
        end, { "i", "s", "c", })
    }
})

lsp.setup()

function toggle_fold(char)
    local fold_command = ''

    if vim.fn.foldlevel('.') > 0 then
        fold_command = 'za'
    else
        fold_command = 'va' .. char .. 'zf'
    end

    vim.cmd('normal! ' .. fold_command)
end

-- smart column
local smartcolumn_config = {
    colorcolumn = "120",
    disabled_filetypes = { "help", "text", "markdown", "fern" },
    custom_colorcolumn = {},
    scope = "line",
}

require("smartcolumn").setup(smartcolumn_config)

-- Telescope
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
local noice = require('noice')

telescope.setup()
telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")
telescope.load_extension("zf-native")
telescope.load_extension("notify")

-- Fern
vim.g['fern#renderer'] = 'nerdfont'

-- Ajoute cette fonction à ton init.lua
function Close_nvim_if_last_fern_buffer()
    -- Vérifie si le seul buffer ouvert a un filetype "fern"
    local num_windows = vim.fn.winnr('$') - 1
    print(num_windows)

    if num_windows == 1 and vim.api.nvim_buf_get_option(0, 'filetype') == 'fern' then
        vim.cmd('qall!')
    end
end

-- Ajoute cette autocmd pour appeler la fonction avant de quitter Neovim
vim.api.nvim_exec(
    [[
augroup CloseNvimIfLastFernBuffer
    autocmd!
    autocmd WinClosed,WinClosed,VimLeavePre lua close_nvim_if_last_fern_buffer()
augroup END
]],
    false)


-- Indentation left and right
km.set('n', '<C-l>', '>>', { noremap = true, silent = true })
km.set('n', '<C-h>', '<<', { noremap = true, silent = true })
km.set('v', '<C-h>', '<gv', { noremap = true, silent = true })
km.set('v', '<C-l>', '>gv', { noremap = true, silent = true })

-- Moving current cursor top and bototm
km.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true, silent = true })
km.set('n', '<C-k>', ':m .-2<CR>==', { noremap = true, silent = true })
km.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
km.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- NvimTree
km.set('n', '<Leader>,', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

--Format
km.set('n', '<C-§>', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- Remaps
-- edition
km.set("n", "<leader>rw", ":g/^$/d<CR>")
-- search
km.set("n", "<leader>\\", ":noh<CR>")
-- buffers
km.set("n", "<leader>bn", ":bnext<CR>")
km.set("n", "<leader>bp", ":bprevious<CR>")
km.set("n", "<leader>bd", ":bd!<CR>")
km.set("n", "<leader>br", ":redraw<CR>")
km.set("n", "<leader>bx", ":%bd|e#<CR>")
--tabs
km.set("n", "<leader>tt", ":tabnew<CR>")
km.set("n", "<leader>tc", ":tabclose<CR>")
km.set("n", "<leader>tn", ":tabnext<CR>")
km.set("n", "<leader>tp", ":tabprev<CR>")
-- window splits
km.set("n", "<leader>ws", "<C-w>s")
km.set("n", "<leader>wsj", "<C-w>s<C-w>j")
km.set("n", "<leader>wv", "<C-w>v")
km.set("n", "<leader>wvl", "<C-w>v<C-w>l")
km.set("n", "<leader>wvh", "<C-w>v<C-w>h")
km.set("n", "<leader>ww", "<C-w>n")
km.set("n", "<leader>wx", "<C-w>x") -- swap with the split on the right
km.set("n", "<leader>wr", "<C-w>r") -- rotates clockwise
km.set("n", "<leader>wR", "<C-w>R") -- rotates counterclockwise
km.set("n", "<leader>wc", "<C-w>q")
km.set("n", "<leader>wj", "<C-w>j")
km.set("n", "<leader>wk", "<C-w>k")
km.set("n", "<leader>wh", "<C-w>h")
km.set("n", "<leader>wl", "<C-w>l")

km.set("n", "gj", "<C-w>j")
km.set("n", "gk", "<C-w>k")
km.set("n", "gh", "<C-w>h")
km.set("n", "gl", "<C-w>l")

km.set("n", "<leader>mp", ":rightbelow vsplit | terminal glow %<CR>")
-- Telescope
km.set('n', '<leader>ff', builtin.find_files, {})
km.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { silent = true, noremap = true })
km.set('n', '<leader>bl', builtin.buffers, {})
km.set('n', '<leader>pf', builtin.git_files, {})
km.set('n', '<leader>fo', builtin.oldfiles, {})
km.set('n', '<leader>pg', builtin.git_status, {})
km.set('n', '<leader>pt', ':Telescope file_browser<CR>', {})
km.set('n', '<leader>pn', ':Telescope notify<CR>', {})
km.set("n", "<leader>/", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
km.set("n", "<leader>pV", live_grep_args_shortcuts.grep_visual_selection)
-- notify
km.set("n", "<leader>nc", notify.dismiss, {})
km.set("n", "<leader>nl", function() noice.cmd("last") end)
km.set("n", "<leader>nh", function() noice.cmd("history") end)
-- fern
km.set("n", "<leader>ee", ":Fern . -drawer -width=60 -toggle -right<CR>", { silent = true, noremap = true })
km.set("n", "<leader>es", ":Fern . -reveal=% -drawer -width=60 -toggle -right<CR>", { silent = true, noremap = true })
-- Trouble
km.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { silent = true, noremap = true })
-- Scretch
km.set('n', '<leader>sn', scretch.new)
km.set('n', '<leader>snn', scretch.new_named)
km.set('n', '<leader>sft', scretch.new_from_template)
km.set('n', '<leader>sat', scretch.save_as_template)
km.set('n', '<leader>sl', scretch.last)
km.set('n', '<leader>ss', scretch.search)
km.set('n', '<leader>st', scretch.edit_template)
km.set('n', '<leader>sg', scretch.grep)
km.set('n', '<leader>sv', scretch.explore)
-- undotree
km.set('n', '<leader>u', vim.cmd.UndotreeToggle)
-- folds
km.set('n', 'z}', ':lua toggle_fold("}")<CR>', { noremap = true, silent = true })
km.set('n', 'z{', ':lua toggle_fold("{")<CR>', { noremap = true, silent = true })
km.set('n', 'z)', ':lua toggle_fold(")")<CR>', { noremap = true, silent = true })
km.set('n', 'z(', ':lua toggle_fold("(")<CR>', { noremap = true, silent = true })
km.set('n', 'z]', ':lua toggle_fold("]")<CR>', { noremap = true, silent = true })
km.set('n', 'z[', ':lua toggle_fold("[")<CR>', { noremap = true, silent = true })
km.set('n', 'zT', ':lua toggle_fold("t")<CR>', { noremap = true, silent = true })
