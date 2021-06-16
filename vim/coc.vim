" ----------------------------------------------------------------------------
"  coc.nvim
" ----------------------------------------------------------------------------

let g:coc_disable_transparent_cursor = 1
" <TAB>: completion.
imap <silent><expr> <TAB>
      \ pumvisible() ? "<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || strpart(getline('.'), 0, col) =~ '^\s*$'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Formatting selected code.
xmap <leader>c=  <Plug>(coc-format-selected)
nmap <leader>c=  <Plug>(coc-format-selected)
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>cR <Plug>(coc-refactor)
nmap <leader>cf  <Plug>(coc-fix-current)
nmap <leader>ce :CocCommand eslint.executeAutofix<cr>
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
nmap <leader>.  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>.  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <silent><nowait> <leader>cd :<C-u>CocList --normal diagnostics<cr>
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
nmap <silent> <leader>ci <Plug>(coc-diagnostic-info)
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>

" navigate chunks of current buffer
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [gc <Plug>(coc-git-prevconflict)
nmap ]gc <Plug>(coc-git-nextconflict)
" show chunk diff at current position
" nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <leader>gh <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

set shortmess+=c

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetNext', [])\<CR>"
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

augroup cocau
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

let g:coc_config_home = "$HOME/.config/nvim/"

" Extensions
let g:coc_global_extensions = [
      \  'coc-css',
      \  'coc-git',
      \  'coc-highlight',
      \  'coc-html',
      \  'coc-jest',
      \  'coc-json',
      \  'coc-yaml',
      \  'coc-tsserver',
      \  'coc-prettier',
      \  'coc-snippets',
      \  'coc-sh',
      \  'coc-emoji'
      \ ]

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-D>"
nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-U>"
inoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Right>"
inoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Left>"


" Coc prettier manual format
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
