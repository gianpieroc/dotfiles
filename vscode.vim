call plug#begin('~/.config/nvim-vscode/plug')
" Essential
" Plug 'tpope/vim-git'
Plug 'asvetliakov/vim-easymotion'
" Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-sleuth'
" Plug 'mbbill/undotree'
" Easyclip
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'
Plug 'svermeulen/vim-subversive'
Plug 'justinmk/vim-sneak'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-after-object'
call plug#end()

set clipboard=unnamedplus

nnoremap <Tab> :Tabnext<CR>
nnoremap <S-Tab> :Tabprevious<CR>

source ~/.config/nvim/vim/objects.vim
source ~/.config/nvim/vim/sensible.vim

" ----------------------------------------------------------------------------
"   VSCode
" ----------------------------------------------------------------------------

nmap <leader>. <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nmap ]e <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
nmap [e <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>
nmap [e <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>
nmap <leader>n <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
nmap <leader>t <Cmd>call VSCodeNotify('workbench.action.terminal.focus')<CR>
function! s:vscodePrepareMultipleCursors(append, skipEmpty)
    let m = mode()
    if m ==# 'V' || m ==# "\<C-v>"
        let b:notifyMultipleCursors = 1
        let b:multipleCursorsVisualMode = m
        let b:multipleCursorsAppend = a:append
        let b:multipleCursorsSkipEmpty = a:skipEmpty
        " We need to start insert, then spawn cursors otherwise they'll be destroyed
        " using feedkeys() here because :startinsert is being delayed
        call feedkeys("o\<Esc>i", 'n')
    endif
endfunction

function! s:vscodeNotifyMultipleCursors()
    if exists('b:notifyMultipleCursors') && b:notifyMultipleCursors
        let b:notifyMultipleCursors = 0
        call VSCodeExtensionNotify('visual-edit', b:multipleCursorsAppend, b:multipleCursorsVisualMode, line("'<"), line("'>"), col("'>"), b:multipleCursorsSkipEmpty)
    endif
endfunction

augroup MultipleCursors
    autocmd!
    autocmd InsertEnter * call <SID>vscodeNotifyMultipleCursors()
augroup END

" Multiple cursors support for visual line/block modes
xnoremap a <Cmd>call <SID>vscodePrepareMultipleCursors(1, 1)<CR>
xnoremap i <Cmd>call <SID>vscodePrepareMultipleCursors(0, 1)<CR>
xnoremap A <Cmd>call <SID>vscodePrepareMultipleCursors(1, 0)<CR>
xnoremap I <Cmd>call <SID>vscodePrepareMultipleCursors(0, 0)<CR>

" ----------------------------------------------------------------------------
" Git
" ----------------------------------------------------------------------------
nmap <leader>gs <Cmd>call VSCodeNotify('workbench.view.scm')<CR>
nmap <leader>gp <Cmd>call VSCodeNotify('git.pull')<CR>
nmap <leader>gP <Cmd>call VSCodeNotify('git.push')<CR>

" ----------------------------------------------------------------------------
" EasyAlign
" ----------------------------------------------------------------------------
vmap <Enter> <Plug>(EasyAlign)

" ----------------------------------------------------------------------------
" Easyclip
" ----------------------------------------------------------------------------
let g:yoinkIncludeDeleteOperations = 1
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
nmap ]p <plug>(YoinkPostPasteSwapBack)
nmap [p <plug>(YoinkPostPasteSwapForward)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap Y <plug>(SubversiveSubstituteRange)
let g:subversivePromptWithActualCommand = 1


nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

" ----------------------------------------------------------------------------
"   DelimitMate
" ----------------------------------------------------------------------------
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

nmap gow <Plug>(easymotion-bd-w)
nmap gos <Plug>(easymotion-s)
nmap <CR> <Plug>(easymotion-bd-jk)
nmap gon <Plug>(easymotion-vim-n)
nmap goN <Plug>(easymotion-vim-N)
