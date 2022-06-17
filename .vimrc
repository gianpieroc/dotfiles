

call plug#begin(vim_folder.'/plug')

"  -------
"  PLUGINS
"  -------

" Essential
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-subversive'
Plug 'Raimondi/delimitMate'

" Language specific
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'othree/html5.vim', { 'for': 'html' }

"colorscheme
Plug 'jacoborus/tender'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-emoji'

call plug#end()

"  ------------
"  COLORSCHEMES
"  ------------
"
set termguicolors
set background=dark
silent! colorscheme gruvbox


function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline().' ' : ''}"
  let coc_status = "%{coc#status()}%{get(b:,'coc_current_function','')}"
  let coc = l:coc_status != '' ? '[Coc('.coc_status.')]' : ''
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %f %<'.mod.ro.ft.fug.coc.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

source $HOME/dotfiles/vim/fzf.vim
source $HOME/dotfiles/vim/coc.vim

" ---------------
"  BASICS
" ---------------
set backspace=2
set nu
set rnu
set showcmd
set nojoinspaces
set ruler
set showmatch
set scrolloff=2
set wrap
set linebreak
set breakat-=*
set wildmenu
set shiftwidth=2
set tabstop=2
set conceallevel=0
set autoread
set nosol
set hidden
set ignorecase smartcase
set nobackup
set noshowmode
set nolist
set expandtab smarttab
let mapleader = ' '
let maplocalleader = ' '

" ----------------
" WINDOWS CONTROLS
" ----------------
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

"  ------------
"  VIM-SURROUND
"  ------------
"
nmap s{ ysil{
nmap s} ySil{

"  -------
"  VIM-GIT
"  -------
"
nmap <leader>gs :Gstatus<CR>gg<c-n>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gl :0Gclog!<CR>
nmap <leader>gE :Gvsplit<CR>
nmap <leader>gv :GV -n 100<CR>
nmap <leader>gV :GV!<CR>
nmap git :Git
let g:Gitv_OpenHorizontal = 1
let g:Gitv_OpenPreviewOnLaunch = 1


"  --------
"  NERDTREE
"  --------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>



