return {
    'dense-analysis/ale',
    config = function()
        local g = vim.g

        g.ale_ruby_rubocop_auto_correct_all = 1
        g.ale_fixers = {'prettier'}

        g.ale_linters_aliases = {
            jsx = {'css', 'javascript'},
            tsx = {'css', 'javascript'}
        }

        g.ale_linters = {
            ruby = {'rubocop', 'ruby'},
            lua = {'lua_language_server'},
            javascript = {'eslint', 'cspell', 'stylelint'},
            typescript = {'eslint', 'cspell', 'stylelint'},
            jsx = {'stylelint', 'eslint'},
            tsx = {'stylelint', 'eslint'}
        }
    end
}
