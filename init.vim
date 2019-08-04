filetype off
if has('nvim')
  let vim_folder = '~/.config/nvim'
else
  let vim_folder = '~/.vim'
endif
if empty(glob(vim_folder.'/autoload/plug.vim'))
  exec 'silent !mkdir -p '.vim_folder.'/autoload'
  exec 'silent !curl -fLo '.vim_folder.'/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

call plug#begin(vim_folder.'/plug')

" ----------------------------------------------------------------------------
"  Local vimrc
" ----------------------------------------------------------------------------
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Essential
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-dispatch'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'neomake/neomake'
Plug 'kassio/neoterm'
Plug 'scrooloose/nerdtree'
Plug 'svermeulen/vim-easyclip'
Plug 'w0rp/ale'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'itchyny/calendar.vim'
Plug 'junegunn/vim-emoji'
if has('python3') && has('nvim')
  Plug 'Shougo/deoplete.nvim'
  Plug 'SirVer/ultisnips'
  if executable("node")
    Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern' }
    Plug 'ternjs/tern_for_vim', { 'do': 'yarn' }
  endif
  if executable("cargo")
    function! InstallRacer(info)
      !cargo install racer
      !rustup component add rust-src
    endfunction
    Plug 'sebastianmarkow/deoplete-rust', { 'do': function('InstallRacer') }
  endif
endif

" Language specific
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'othree/yajs.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'mxw/vim-jsx'
Plug 'rust-lang/rust.vim'
Plug 'elzr/vim-json'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'raichoo/haskell-vim', { 'for': 'haskell' }
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

" Colorschemes
Plug 'jacoborus/tender'
Plug 'junegunn/seoul256.vim'
Plug 'tomasr/molokai'
Plug 'yuttie/hydrangea-vim'
Plug 'morhetz/gruvbox'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'AlessandroYorba/Despacio'
Plug 'cocopon/iceberg.vim'
Plug 'w0ng/vim-hybrid'
if executable('node')
  Plug 'prettier/vim-prettier', { 'do': 'yarn install'}
endif


call plug#end()

" ----------------------------------------------------------------------------
" Colorschemes
" ----------------------------------------------------------------------------
syntax enable
if has("termguicolors")
    set termguicolors
    set background=dark
    silent! colorscheme gruvbox
    "hi ColorColumn guibg=#111111
    " colorscheme solarized
else
    let g:seoul256_background = 233
    silent! colorscheme seoul256
    hi MatchParen ctermfg=yellow
    "let g:indentLine_color_term = 248
    hi ColorColumn ctermbg=234 guibg=#111111
endif

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
set incsearch
set wildmenu
let g:html_indent_inctags = "html,body,head,tbody"
let mapleader = ' '
let maplocalleader = ' '
set shiftwidth=2
set tabstop=2
set conceallevel=0
set autoread
set nosol
"set clipboard=unnamed
set ignorecase smartcase
set nobackup
set nowritebackup
set noshowmode
set nolist
set expandtab smarttab
set virtualedit=block
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup
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
set mouse=a
set nostartofline
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()
"hi StatusLine ctermfg=232 ctermbg=45 guibg=#00bff4 guifg=#000000
"hi StatusLineNC ctermfg=232 ctermbg=237 guibg=#777777 guifg=#000000
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    set ttimeout
    set ttimeoutlen=0
else
    set nocompatible
    set noswapfile
endif

" let g:markdown_composer_autostart = 0
let g:jsx_ext_required = 0
let g:ag_working_path_mode="r"
let g:javascript_conceal = 1
set cole=1

" ----------------------------------------------------------------------------
" Fix Indent
" ----------------------------------------------------------------------------
augroup FTOptions
  autocmd!
  au BufNewFile,BufReadPost *.css set filetype=sass
  au BufNewFile,BufReadPost *.tsx,*.ts set filetype=javascript.jsx
  au BufWritePost vimrc,.vimrc,init.vim nested if expand('%') !~ 'fugitive' | source % | endif
  au filetype racket set lisp
  au filetype racket set autoindent
  au BufReadPost quickfix nmap <buffer> <CR> :.cc<CR>
  au FileType perl let b:dispatch = 'perl -Wc %'
  au FileType javascript.jsx let b:dispatch = 'node %'
  au BufNewFile,BufReadPost *.test.js let b:dispatch = 'yarn test %'
  au BufReadPost * if getline(1) =~# '^#!' | let b:dispatch = getline(1)[2:-1] . ' %' | let b:start = b:dispatch | endif
augroup END
filetype plugin indent on

" ----------------------------------------------------------------------------
"  Tabs
" ----------------------------------------------------------------------------
set list listchars=tab:¦\ ,trail:·,extends:»,precedes:«,nbsp:×

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
" cd changes directory to the current file's
nmap cd :cd %:p:h<CR>
" Retain cursor position on page scrolling
noremap <C-F> <C-D>
noremap <C-B> <C-U>
" change L and H to ^ and $
onoremap H ^
onoremap L $
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
inoremap <silent> <c-t> <C-R>=strftime("%c")<CR>
inoremap <c-l> <space>=><space>
cnoremap <expr> %% expand('%:h').'/'
cnoremap <expr> !! expand('%:p')
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
" RENAME CURRENT FILE
" ----------------------------------------------------------------------------
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>r :call RenameFile()<cr>

" ----------------------------------------------------------------------------
" OpenChangedFiles COMMAND
" ----------------------------------------------------------------------------
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "tab split " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

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
nmap <down> :res -2<CR>
nmap <up> :res +2<CR>
nmap <right> 2<C-W>>
nmap <left> 2<C-W><
nmap <C-w>- :sp<CR>
nmap <C-w>\ :vsp<CR>

" ----------------------------------------------------------------------------
"  Surround
" ----------------------------------------------------------------------------
nmap s{ ysil{
nmap s} ySil{

" ----------------------------------------------------------------------------
"  Sneak
" ----------------------------------------------------------------------------
nmap gf  <Plug>Sneak_s
omap gf  <Plug>Sneak_s
nmap gb <Plug>Sneak_S
omap gb <Plug>Sneak_S

" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
" silent! exe "set <S-Left>=\<Esc>b"
" silent! exe "set <S-Right>=\<Esc>f"

" ----------------------------------------------------------------------------
" Git
" ----------------------------------------------------------------------------
nmap <leader>gp :Gpull<CR>
nmap <leader>gP :Gpush<CR>
nmap <leader>gs :Gstatus<CR>gg<c-n>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>ge :Gedit<CR>
nmap <leader>gE :Gvsplit<CR>
nmap <leader>gv :GV<CR>
nmap <leader>gV :GV!<CR>
nmap <leader>gg :Ggrep 
nmap git :Git
nmap [r :Git rebase --abort<CR>
nmap ]r :Git rebase --continue<CR>
let g:Gitv_OpenHorizontal = 1
let g:Gitv_OpenPreviewOnLaunch = 1

" ----------------------------------------------------------------------------
"  GitGutter
" ----------------------------------------------------------------------------
nmap <leader>gh :GitGutterLineHighlightsToggle<CR>

" ----------------------------------------------------------------------------
" EasyAlign
" ----------------------------------------------------------------------------
vmap <Enter> <Plug>(EasyAlign)

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
function! NERDTreeFindOrToggle()
  let s:empty = @% == "" || filereadable(@%) == 0 || line('$') == 1 && col('$') == 1
  if s:empty || exists("b:fugitive_type") || exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
    :NERDTreeToggle
  else
    :NERDTreeFind
  endif
endfunction
map <silent> <Leader>n :call NERDTreeFindOrToggle()<CR>

function! NERDTreeFindUpdate()
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1 && expand("%:p") =~ getcwd() && !exists("b:fugitive_type")
    :NERDTreeFind
    exec "normal! \<c-w>p"
  endif
endfunction

augroup nerd
  autocmd!
  autocmd BufReadPost * call NERDTreeFindUpdate()
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd'
        \| endif
augroup END

" ----------------------------------------------------------------------------
" Easyclip
" ----------------------------------------------------------------------------
let g:EasyClipUseSubstituteDefaults = 1
let g:EasyClipPreserveCursorPositionAfterYank = 1
" let g:EasyClipAutoFormat = 1
let g:EasyClipShareYanks = 1
let g:EasyClipUsePasteToggleDefaults = 0
nmap [y <Plug>EasyClipSwapPasteBackwards
nmap ]y <Plug>EasyClipSwapPasteForward
imap <c-v> <Plug>EasyClipInsertModePaste
nmap M mL

" ----------------------------------------------------------------------------
"  Prettier
" ----------------------------------------------------------------------------
nmap <Leader>pp <Plug>(Prettier)
let g:prettier#autoformat = 1
let g:prettier#config#print_width = 80
let g:prettier#config#single_quote = 'false'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#config_precedence = 'prefer-file'
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" let g:prettier#autoformat = 1

" ----------------------------------------------------------------------------
"  CtrlP
" ----------------------------------------------------------------------------
set wildignore+=*/tmp/*,*.so,*.sw?,*.zip,*/vendor/*,*/bower_components/*,*/node_modules/*,*/dist/*
"let g:ctrlp_match_window_bottom = 0
let g:ctrlp_mru_files = 1
let g:ctrlp_extensions = ['merge', 'checkout']
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_working_path_mode = 'ra'

" ----------------------------------------------------------------------------
"  FZF
" ----------------------------------------------------------------------------
if has('nvim')
    let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

function! CTRLP()
  if expand('%') =~ 'NERD_tree'
    exec "normal! \<c-w>w"
  endif
  Files
endfunction
command! CTRLP call CTRLP()
nnoremap <silent> <C-p> :CTRLP<CR>
nnoremap <leader>/ :Ag 

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

set rtp+=~/.fzf

function! s:merge_handler(line)
    exec "Git merge --no-ff --no-commit ".a:line
endfunction

command! FZFMerge call fzf#run({
            \ 'source': 'git branch -r --no-merged',
            \ 'sink': function('s:merge_handler'),
            \ 'down': 8})

function! s:dir_handler(dir)
    echo a:dir
endfunction

function! s:get_log_ref(line)
    return matchstr(a:line, '[0-9a-f]\{7}')
endfunction

function! s:branch_handler(line)
    exec "!git checkout ".a:line
endfunction

function! s:ref_handler(line)
    exec "Gvdiff ".s:get_log_ref(a:line)."^"
endfunction

function! s:fzf_show_commits(here, handler)
    let options  = [
                \ '--color=always',
                \ '--format="%C(auto)%h%d %s %C(magenta)%an, %cr"']

    if a:here
      call add(options, '--follow -- '.expand("%:P"))
    endif

    call fzf#run({
                \ 'source': 'git log '.join(options, ' '),
                \ 'sink': a:handler,
                \ 'options': '--ansi --multi --no-sort --tiebreak=index --reverse '.
                \   '--inline-info -e --prompt "Commit> " --bind=ctrl-s:toggle-sort',
                \ 'left': '50%'})
endfunction

function! s:fzf_show_branches(handler)
  call fzf#run({
        \ 'source': 'git branch',
        \ 'sink': a:handler,
        \ 'options': '--ansi --multi --no-sort --tiebreak=index --reverse '.
        \   '--inline-info -e --prompt "Commit> " --bind=ctrl-s:toggle-sort',
        \ 'left': '50%'})
endfunction

command! -nargs=0 FZFCheckout call s:fzf_show_branches(function('s:branch_handler'))
command! -nargs=0 FZFGitLog call s:fzf_show_commits(1, function('s:ref_handler'))
nmap <silent> <leader>gc :FZFCheckout<CR>
nmap <silent> <leader>gl :FZFGitLog<CR>
nmap <silent> <leader>gm :FZFMerge<CR>

function! s:get_changes_list()
  redir => result
  :silent changes
  redir END
  return reverse(split(result, "\n")[1:])[1:]
endfunction

function! s:fzf_handle_change(line)
  let elements = matchlist(a:line, '\v^(.)\s*(\d+)\s+(\d+)\s+(\d+)\s*(.*)$')
  if empty(elements)
    return {}
  endif
  let parsed = {
        \   'prefix': elements[1],
        \   'count' : elements[2],
        \   'lnum'  : elements[3],
        \   'column': elements[4],
        \   'text'  : elements[5],
        \ }
  call cursor(parsed.lnum, parsed.column)
endfunction

command! -nargs=0 FZFChanges call fzf#run({
      \ 'source': s:get_changes_list(),
      \ 'sink': function('s:fzf_handle_change'),
      \ 'down': 8,
      \ })

nmap <silent> <leader>g; :FZFChanges<CR>

let g:fzf_files_options = '-e --preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_buffers_jump = 1

" ----------------------------------------------------------------------------
"   DelimitMate
" ----------------------------------------------------------------------------
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1

" ----------------------------------------------------------------------------
" HL | Find out syntax group
" ----------------------------------------------------------------------------
function! s:hl()
  return map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
command! HL echo join(<SID>hl(), '/')

" ----------------------------------------------------------------------------
"   HTML/JSX autoclose tag
" ----------------------------------------------------------------------------
let s:closed_tag_regexp = '<\/\(\w\|\.\)\+>'
let s:tag_name_regexp = '<\(\w\|\.\|:\)\+'
let s:tag_properties = '\s*\(\s\+[^>]\+\s*\)*'
let s:tag_regexp = s:tag_name_regexp.s:tag_properties.'[^\/]'
let s:tag_blacklist = ['TMPL_*', 'input', 'br']
let s:hl_whitelist = ['xmlTag']
function! CarriageReturn()
  if has('python3')
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
      return snippet
    endif
  endif
  let col = col('.') - 1
  let line = getline('.')
  if col && strpart(line, col) =~ '^'.s:closed_tag_regexp && strpart(line, 0, col) =~ s:tag_name_regexp
    return "\<CR>\<Esc>".'zvO'
  endif
  return delimitMate#ExpandReturn()
endfunction
inoremap <silent> <CR> <C-R>=CarriageReturn()<CR>

function! CloseTag()
    let n = getline('.')
    let column = col('.') - 1
    let hl = s:hl()
    let close = '>'
    if !column
      return close
    endif
    for item in s:hl_whitelist
      if index(hl, item) == -1
        return close
      endif
    endfor
    let line_before_cursor = strpart(n, 0, column)
    if line_before_cursor !~ s:tag_regexp.'$'
      return close
    endif
    let tag = matchstr(line_before_cursor, s:tag_name_regexp.'\('.s:tag_properties.'$\)\@=')
    for item in s:tag_blacklist
      if tag =~ item
        return close
      endif
    endfor
    return '></'.strpart(tag, 1).'>'."\<Esc>F>a"
endfunction
function! EraseTag()
    let n = line('.')
    let line = getline(n)
    let col = col('.') - 1
    if col
    \ && strpart(line, 0, col) =~ s:tag_regexp.'>$'
    \ && strpart(line, col) =~ '^'.s:closed_tag_regexp
        return "\<Esc>cf>"
    endif
    if n > 0
        let before = getline(n - 1)
        let after = getline(n + 1)
        if line =~ '^\s*$'
        \ && after =~  '^\s*'.s:closed_tag_regexp
        \ && before =~ s:tag_regexp.'>$'
            return "\<Esc>kJJhct<"
        endif
    endif
    return delimitMate#BS()
endfunction
augroup autoclose_tags
  autocmd!
  autocmd FileType javascript.jsx inoremap <buffer> <silent> > <C-R>=CloseTag()<CR>
  autocmd FileType javascript.jsx inoremap <buffer> <silent> <BS> <C-R>=EraseTag()<CR>
  autocmd FileType html,xml inoremap <buffer> <silent> <BS> <C-R>=EraseTag()<CR>
augroup END

" ----------------------------------------------------------------------------
"  vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

" ----------------------------------------------------------------------------
"  JSDoc
" ----------------------------------------------------------------------------
nmap doc <Plug>(jsdoc)
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_return = 0

" ----------------------------------------------------------------------------
"  UltiSnips
" ----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = "<C-u>"
let g:UltiSnipsSnippetsDir = vim_folder."/UltiSnips"
let g:ulti_expand_or_jump_res = 0

" ----------------------------------------------------------------------------
"  Dispatch
" ----------------------------------------------------------------------------
nmap <F9> :Dispatch<CR>

" ----------------------------------------------------------------------------
"  Tmux
" ----------------------------------------------------------------------------
nmap <silent> @ :Tmux resize-pane -Z<CR>
function! s:zoom()
  Tmux resize-pane -Z
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
        \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
" nnoremap <silent> <CR> :call <sid>zoom()<cr>

" ----------------------------------------------------------------------------
"  Deoplete
" ----------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:tern#arguments = ["--persistent"]
set completeopt=menuone,noselect
if executable("racer")
  let g:deoplete#sources#rust#racer_binary = "/Users/etf/.cargo/bin/racer"
  let g:deoplete#sources#rust#rust_source_path = systemlist("rustc --print sysroot")[0]."/lib/rustlib/src/rust/src"
endif


" <TAB>: completion.
imap <silent><expr> <TAB>
            \ <SID>check_back_space() ? "\<TAB>" :
            \ "<C-n>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || strpart(getline('.'), 0, col) =~ '^\s*$'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'

inoremap <silent><expr> <C-t> deoplete#mappings#manual_complete('file')

let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_camel_case = 1

" ----------------------------------------------------------------------------
" DiffRev
" ----------------------------------------------------------------------------
let s:git_status_dictionary = {
            \ "A": "Added",
            \ "B": "Broken",
            \ "C": "Copied",
            \ "D": "Deleted",
            \ "M": "Modified",
            \ "R": "Renamed",
            \ "T": "Changed",
            \ "U": "Unmerged",
            \ "X": "Unknown"
            \ }
function! s:get_diff_files(rev)
  let list = map(split(system(
              \ 'git diff --name-status '.a:rev), '\n'),
              \ '{"filename":matchstr(v:val, "\\S\\+$"),"text":s:git_status_dictionary[matchstr(v:val, "^\\w")]}'
              \ )
  call setqflist(list)
  copen
endfunction

command! -nargs=1 DiffRev call s:get_diff_files(<q-args>)


" ----------------------------------------------------------------------------
" co? : Toggle options (inspired by unimpaired.vim)
" ----------------------------------------------------------------------------
function! s:map_change_option(...)
    let [key, opt] = a:000[0:1]
    let op = get(a:, 3, 'set '.opt.'!')
    execute printf("nnoremap co%s :%s<bar>echo '%s: '. &%s<cr>",
                \ key, op, opt, opt)
endfunction

call s:map_change_option('p', 'paste')
call s:map_change_option('n', 'number')
call s:map_change_option('w', 'wrap')
call s:map_change_option('h', 'hlsearch')
call s:map_change_option('m', 'mouse', 'let &mouse = &mouse == "" ? "a" : ""')
call s:map_change_option('t', 'textwidth',
            \ 'let &textwidth = input("textwidth (". &textwidth ."): ")<bar>redraw')
call s:map_change_option('b', 'background',
            \ 'let &background = &background == "dark" ? "light" : "dark"<bar>redraw')
nnoremap cogg :GitGutterLineHighlightsToggle<CR>

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
      return root
  endif
endfunction
command! Root execute 'lcd'.s:root()

" ----------------------------------------------------------------------------
" #]i / #[i | go to next/previous indentation level
" ----------------------------------------------------------------------------
function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i && !empty(line)
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> ]i :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> [i :<c-u>call <SID>go_indent(v:count1, -1)<cr>


" ----------------------------------------------------------------------------
" TX
" ----------------------------------------------------------------------------
command! -nargs=1 TX
  \ call system('tmux split-window -d -l 16 '.<q-args>)
nnoremap !! :TX<space>

" ----------------------------------------------------------------------------
" Common
" ----------------------------------------------------------------------------
function! s:textobj_cancel()
  if v:operator == 'c'
    augroup textobj_undo_empty_change
      autocmd InsertLeave <buffer> execute 'normal! u'
            \| execute 'autocmd! textobj_undo_empty_change'
            \| execute 'augroup! textobj_undo_empty_change'
    augroup END
  endif
endfunction

noremap         <Plug>(TOC) <nop>
inoremap <expr> <Plug>(TOC) exists('#textobj_undo_empty_change')?"\<esc>":''

" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:indent_object(op, skip_blank, b, e, bd, ed)
  let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
  let x = line('$')
  let d = [a:b, a:e]

  if i == 0 && empty(getline(a:b)) && empty(getline(a:e))
    let [b, e] = [a:b, a:e]
    while b > 0 && e <= line('$')
      let b -= 1
      let e += 1
      let i = min(filter(map([b, e], 's:indent_len(getline(v:val))'), 'v:val != 0'))
      if i > 0
        break
      endif
    endwhile
  endif

  for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
    let [o, ev, df] = triple

    while eval(ev)
      let line = getline(d[o] + df)
      let idt = s:indent_len(line)

      if eval('idt '.a:op.' i') && (a:skip_blank || !empty(line)) || (a:skip_blank && empty(line))
        let d[o] += df
      else | break | end
    endwhile
  endfor
  execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction
xnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
xnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
xnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>

" ----------------------------------------------------------------------------
" <Leader>I/A | Prepend/Append to all adjacent lines with same indentation
" ----------------------------------------------------------------------------
nmap <silent> <leader>I ^vio<C-V>I
nmap <silent> <leader>A ^vio<C-V>$A

" ----------------------------------------------------------------------------
" ?i_ ?a_ ?i. ?a. ?i, ?a, ?i/
" ----------------------------------------------------------------------------
function! s:between_the_chars(incll, inclr, char, vis)
  let cursor = col('.')
  let line   = getline('.')
  let before = line[0 : cursor - 1]
  let after  = line[cursor : -1]
  let [b, e] = [cursor, cursor]

  try
    let i = stridx(join(reverse(split(before, '\zs')), ''), a:char)
    if i < 0 | throw 'exit' | end
    let b = len(before) - i + (a:incll ? 0 : 1)

    let i = stridx(after, a:char)
    if i < 0 | throw 'exit' | end
    let e = cursor + i + 1 - (a:inclr ? 0 : 1)

    execute printf("normal! 0%dlhv0%dlh", b, e)
  catch 'exit'
    call s:textobj_cancel()
    if a:vis
      normal! gv
    endif
  finally
    " Cleanup command history
    if histget(':', -1) =~ '<SNR>[0-9_]*between_the_chars('
      call histdel(':', -1)
    endif
    echo
  endtry
endfunction

for [s:c, s:l] in items({'_': 0, '.': 0, ',': 0, '/': 1, '-': 0})
  execute printf("xmap <silent> i%s :<C-U>call <SID>between_the_chars(0,  0, '%s', 1)<CR><Plug>(TOC)", s:c, s:c)
  execute printf("omap <silent> i%s :<C-U>call <SID>between_the_chars(0,  0, '%s', 0)<CR><Plug>(TOC)", s:c, s:c)
  execute printf("xmap <silent> a%s :<C-U>call <SID>between_the_chars(%s, 1, '%s', 1)<CR><Plug>(TOC)", s:c, s:l, s:c)
  execute printf("omap <silent> a%s :<C-U>call <SID>between_the_chars(%s, 1, '%s', 0)<CR><Plug>(TOC)", s:c, s:l, s:c)
endfor

" ----------------------------------------------------------------------------
" ?ie | entire object
" ----------------------------------------------------------------------------
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?il | inner line
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>

" ----------------------------------------------------------------------------
" ?i# | inner comment
" ----------------------------------------------------------------------------
function! s:inner_comment(vis)
  if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
    call s:textobj_cancel()
    if a:vis
      normal! gv
    endif
    return
  endif

  let origin = line('.')
  let lines = []
  for dir in [-1, 1]
    let line = origin
    let line += dir
    while line >= 1 && line <= line('$')
      execute 'normal!' line.'G^'
      if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
        break
      endif
      let line += dir
    endwhile
    let line -= dir
    call add(lines, line)
  endfor

  execute 'normal!' lines[0].'GV'.lines[1].'G'
endfunction
xmap <silent> i# :<C-U>call <SID>inner_comment(1)<CR><Plug>(TOC)
omap <silent> i# :<C-U>call <SID>inner_comment(0)<CR><Plug>(TOC)

" ----------------------------------------------------------------------------
" ?ic / ?iC | Blockwise column object
" ----------------------------------------------------------------------------
function! s:inner_blockwise_column(vmode, cmd)
  if a:vmode == "\<C-V>"
    let [pvb, pve] = [getpos("'<"), getpos("'>")]
    normal! `z
  endif

  execute "normal! \<C-V>".a:cmd."o\<C-C>"
  let [line, col] = [line('.'), col('.')]
  let [cb, ce]    = [col("'<"), col("'>")]
  let [mn, mx]    = [line, line]

  for dir in [1, -1]
    let l = line + dir
    while line('.') > 1 && line('.') < line('$')
      execute "normal! ".l."G".col."|"
      execute "normal! v".a:cmd."\<C-C>"
      if cb != col("'<") || ce != col("'>")
        break
      endif
      let [mn, mx] = [min([line('.'), mn]), max([line('.'), mx])]
      let l += dir
    endwhile
  endfor

  execute printf("normal! %dG%d|\<C-V>%s%dG", mn, col, a:cmd, mx)

  if a:vmode == "\<C-V>"
    normal! o
    if pvb[1] < line('.') | execute "normal! ".pvb[1]."G" | endif
    if pvb[2] < col('.')  | execute "normal! ".pvb[2]."|" | endif
    normal! o
    if pve[1] > line('.') | execute "normal! ".pve[1]."G" | endif
    if pve[2] > col('.')  | execute "normal! ".pve[2]."|" | endif
  endif
endfunction

xnoremap <silent> ic mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iw')<CR>
xnoremap <silent> iC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iW')<CR>
xnoremap <silent> ac mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aw')<CR>
xnoremap <silent> aC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aW')<CR>
onoremap <silent> ic :<C-U>call   <SID>inner_blockwise_column('',           'iw')<CR>
onoremap <silent> iC :<C-U>call   <SID>inner_blockwise_column('',           'iW')<CR>
onoremap <silent> ac :<C-U>call   <SID>inner_blockwise_column('',           'aw')<CR>
onoremap <silent> aC :<C-U>call   <SID>inner_blockwise_column('',           'aW')<CR>

" ----------------------------------------------------------------------------
" ?i<shift>-` | Inside ``` block
" ----------------------------------------------------------------------------
xnoremap <silent> i~ g_?^```<cr>jo/^```<cr>kV:<c-u>nohl<cr>gv
xnoremap <silent> a~ g_?^```<cr>o/^```<cr>V:<c-u>nohl<cr>gv
onoremap <silent> i~ :<C-U>execute "normal vi`"<cr>
onoremap <silent> a~ :<C-U>execute "normal va`"<cr>

" ----------------------------------------------------------------------------
" <leader>t | vim-tbone
" ----------------------------------------------------------------------------
function! s:tmux_send(content, dest) range
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  let tempfile = tempname()
  call writefile(split(a:content, "\n", 1), tempfile, 'b')
  call system(printf('tmux load-buffer -b vim-tmux %s \; paste-buffer -d -b vim-tmux -t %s',
        \ shellescape(tempfile), shellescape(dest)))
  call delete(tempfile)
endfunction

function! s:tmux_map(key, dest)
  execute printf('nnoremap <silent> %s "tyy:call <SID>tmux_send(@t, "%s")<cr>', a:key, a:dest)
  execute printf('xnoremap <silent> %s "ty:call <SID>tmux_send(@t, "%s")<cr>gv', a:key, a:dest)
endfunction

call s:tmux_map('<leader>tt', '')
call s:tmux_map('<leader>th', '.left')
call s:tmux_map('<leader>tj', '.bottom')
call s:tmux_map('<leader>tk', '.top')
call s:tmux_map('<leader>tl', '.right')
call s:tmux_map('<leader>ty', '.top-left')
call s:tmux_map('<leader>to', '.top-right')
call s:tmux_map('<leader>tn', '.bottom-left')
call s:tmux_map('<leader>t.', '.bottom-right')

" ----------------------------------------------------------------------------
" gv.vim / gl.vim
" ----------------------------------------------------------------------------
function! s:gv_expand()
  let line = getline('.')
  GV --name-status
  call search('\V'.line, 'c')
  normal! zz
endfunction

autocmd! FileType GV nnoremap <buffer> <silent> + :call <sid>gv_expand()<cr>

function! s:gl(buf, l1, l2)
  if !exists(':Gllog')
    return
  endif
  tab split
  silent! execute a:l1 == 1 && a:l2 == line('$') ? '' : "'<,'>" 'Gllog'
  call setloclist(0, insert(getloclist(0), {'bufnr': a:buf}, 0))
  b #
  lopen
  xnoremap <buffer> o :call <sid>gld()<cr>
  nnoremap <buffer> o <cr><c-w><c-w>
  nnoremap <buffer> q :tabclose<cr>
  call matchadd('Conceal', '^fugitive:///.\{-}\.git//')
  call matchadd('Conceal', '^fugitive:///.\{-}\.git//\x\{7}\zs.\{-}||')
  setlocal concealcursor=nvic conceallevel=1 nowrap
endfunction

function! s:gld() range
  let [to, from] = map([a:firstline, a:lastline], 'split(getline(v:val), "|")[0]')
  execute 'tabedit' to
  execute 'vsplit' from
  windo diffthis
endfunction

command! -range=% GL call s:gl(bufnr(''), <line1>, <line2>)

" ----------------------------------------------------------------------------
" goyo.vim + limelight.vim
" ----------------------------------------------------------------------------
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <Leader>G :Goyo 100<CR>
nnoremap <Leader>g :Goyo<CR>

" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>


" ----------------------------------------------------------------------------
" Neomake
" ----------------------------------------------------------------------------
call neomake#configure#automake('w')
let g:neomake_javascript_enabled_makers = []
if executable('eslint')
  let g:neomake_javascript_eslint_exe = exepath('eslint')
  let g:neomake_javascript_enabled_makers += ['eslint']
endif

" ----------------------------------------------------------------------------
" Ale
" ----------------------------------------------------------------------------
silent! if emoji#available()
let g:ale_sign_error = emoji#for('fire')
let g:airline#extensions#ale#enabled = 1
endif
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

" ----------------------------------------------------------------------------
" Easymotion
" ----------------------------------------------------------------------------
nmap g<CR> <Plug>(easymotion-overwin-line)
nmap go <Plug>(easymotion-overwin-w)
nmap gf <Plug>(easymotion-f)
nmap gF <Plug>(easymotion-F)
omap gf <Plug>(easymotion-fl)
omap gF <Plug>(easymotion-Fl)
omap gt <Plug>(easymotion-tl)
omap gT <Plug>(easymotion-Tl)
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#consistent_n_direction = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" ----------------------------------------------------------------------------
" Yank Position
" ----------------------------------------------------------------------------
function! s:YankPosition()
  let @+=@%.'#L'.line('.')
  let @r=@%
  echo 'copied "'.@+.'"'
endfunction
nnoremap <silent> yp :call <sid>YankPosition()<CR>

function! s:PasteRelative()
  if executable("perl")
    " yes im using perl, shoot me
    return "'".system("perl -MFile::Spec -MFile::Basename -e 'print File::Spec->abs2rel(shift, dirname(shift))' ".@r." ".@%)."'"
  elseif
    " yes im using node, shoot me
    return "'".system("node -e \"(p => process.stdout.write(p.relative(p.dirname('".@%."'), '".@r."')))(require('path'))\"")."'"
  endif
  return "¯\\_(ツ)_/¯"
endfunction

nnoremap <silent> yP "=<sid>PasteRelative()<C-M>p

" Replace
nmap coi :%s/import\(\_.\{-}\)from\s\(.\{-}\);/const\1= require(\2);/gc<CR>
nmap cor :%s/const\(\_.\{-}\)=\srequire(\(.\{-}\));/import\1from \2;/gc<CR>
