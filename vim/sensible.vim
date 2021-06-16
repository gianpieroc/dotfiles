" ----------------------------------------------------------------------------
" Basic
" ----------------------------------------------------------------------------
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
let g:html_indent_inctags = "html,body,head,tbody"
let mapleader = ' '
let maplocalleader = ' '
set shiftwidth=2
set tabstop=2
set conceallevel=0
set autoread
set nosol
set hidden
set ignorecase smartcase
set nobackup
set nowritebackup
set noshowmode
set nolist
set expandtab smarttab
set virtualedit=block
" set backupdir=~/.config/nvim/backup
" set directory=~/.config/nvim/backup
set laststatus=2
set pastetoggle=<F7>
set splitbelow
if has('nvim')
  set inccommand=split
endif
if has('patch-7.4.338')
    set showbreak=↳\ 
    set breakindent
    set breakindentopt=sbr
endif
" set encoding=utf-8
set visualbell
set colorcolumn=100
set formatoptions+=rojn
set diffopt=filler,vertical
silent! set ttymouse=xterm2
" set mouse=a
set nostartofline
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    " set ttimeout
    " set ttimeoutlen=0
else
    set nocompatible
    set noswapfile
endif
set updatetime=300

" ----------------------------------------------------------------------------
" Maps
" ----------------------------------------------------------------------------
map <F2> :so $MYVIMRC<CR>
" For inserting new lines
nmap - o<Esc>
nmap _ O<Esc>
" Lazy macro creation
nnoremap Q @q
nmap <leader>q :cope<CR>
" <tab> for tab switcing
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <M-n> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
nnoremap <silent> <M-p> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
" cd changes directory to the current file's
nmap cd :cd %:p:h<CR>
" Retain cursor position on page scrolling
noremap <C-f> <C-D>
noremap <C-b> <C-U>
" change L and H to ^ and $
onoremap H ^
onoremap L $
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
nnoremap Y y$
inoremap <silent> <c-t> <C-R>=strftime("%c")<CR>
inoremap <c-l> <space>=><space>
cnoremap <expr> %% expand('%:h').'/'
cnoremap <expr> !! expand('%:p')
cnoremap <expr> @@ expand('%:p:h').'/'
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> [b :bp<CR>
nnoremap <silent> ]q :cn<CR>zz
nnoremap <silent> [q :cp<CR>zz
nnoremap <silent> <C-t> :tabnew<cr>
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>
inoremap <C-Q> <esc>:q<cr>
nnoremap <C-Q> :q<cr>
inoremap <C-e> <End>
inoremap <C-a> <Home>

" ----------------------------------------------------------------------------
"   Moving lines | for quick line swapping purposes
" ----------------------------------------------------------------------------
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
vnoremap <silent> <C-l> >gv
vnoremap <silent> <C-h> <gv
vnoremap < <gv
vnoremap > >gv

" ----------------------------------------------------------------------------
" Window Controls | much like hjkl but using the g prefix
" ----------------------------------------------------------------------------
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l
" nmap <down> :res -2<CR>
" nmap <up> :res +2<CR>
" nmap <right> 2<C-W>>
" nmap <left> 2<C-W><
nmap <C-w>- :sp<CR>
nmap <C-w>\ :vsp<CR>
