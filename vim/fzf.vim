" ----------------------------------------------------------------------------
"  FZF
" ----------------------------------------------------------------------------
if has('nvim')
    " let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

function! CTRLP()
  let target = expand("%:h")
  if (target == '')
    let target = '.'
  endif
  let root = systemlist('git -C '.target.' rev-parse --show-toplevel')[0]
  if v:shell_error
    let root = $PWD
  endif
  if expand('%') =~ 'NERD_tree'
    exec "normal! \<c-w>w"
  endif
  if executable("fd")
    call fzf#vim#files('', {
          \ 'source': 'fdup '.root.' '.target,
          \ 'options': '--no-sort'
          \ })
  else
    Files
  endif
endfunction
command! CTRLP call CTRLP()
nnoremap <silent> <C-p> :CTRLP<CR>
nnoremap <leader>/ :Ag 
function! AgOn(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use gv command.
    silent exe "normal! gvy"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  else
    silent exe "normal! `[v`]y"
  endif

  exec "Ag ".@@

  let &selection = sel_save
  let @@ = reg_save
endfunction
nmap <silent> y/ :set opfunc=AgOn<CR>g@
vmap <silent> /  :<C-U>call AgOn(visualmode(), 1)<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

set rtp+=~/.fzf

function! s:dir_handler(dir)
    echo a:dir
endfunction

function! s:get_log_ref(line)
    return matchstr(a:line, '^[0-9a-f]\+')
endfunction

function! s:checkout_handler(line)
    exec "Git checkout ".substitute(a:line, "^..", "", "")
endfunction

function! s:diff_handler(line)
    exec "Gvdiff ".s:get_log_ref(a:line)
endfunction

function! s:branch_handler(line)
    let sha = substitute(a:line, "^..", "", "")
    call feedkeys(":Git  ".sha."\<s-left>\<left>", "t")
endfunction


function! s:fzf_show_commits(here, handler)
    let options  = [
                \ '--color=always',
                \ '--no-merges'
                \ '--format="%C(auto)%h%d %s %C(magenta)%an, %cr"'
                \ ]

    let path = expand("%:P")
    if a:here
      call add(options, '--follow -- '.path)
    endif

    call fzf#run({
                \ 'source': 'git log '.join(options, ' ').' | tail -n +2',
                \ 'sink': a:handler,
                \ 'options': '--ansi --multi --no-sort --tiebreak=index '.
                \   '--inline-info -e --prompt "Commit> " --bind=ctrl-s:toggle-sort '.
                \   '--preview='."'".'git diff $(cut -f 1 -d " " <<< {}):'.path.' '.path." | bat --color=always -p'",
                \ 'window': {'width': 0.9, 'height': 0.9}})
endfunction

function! s:fzf_show_branches(handler)
  call fzf#run({
        \ 'source': 'git for-each-ref --sort=-committerdate refs/heads/ --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset)"',
        \ 'sink': a:handler,
        \ 'options': '--ansi --multi --no-sort --tiebreak=index --reverse '.
        \   '--inline-info -e --prompt "Branch> " --bind=ctrl-s:toggle-sort '.
        \   '--preview='."'".'git log --no-merges --oneline --graph -n 100 --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)'."'",
        \ 'window': {'width': 0.9, 'height': 0.6}})
endfunction


command! -nargs=0 FZFCheckout call s:fzf_show_branches(function('s:checkout_handler'))
command! -nargs=0 FZFGitLog call s:fzf_show_commits(1, function('s:ref_handler'))
command! -nargs=0 FZFRef call s:fzf_show_branches(function('s:branch_handler'))
nmap <silent> <leader>gr :FZFRef<CR>
nmap <silent> <leader>gc :FZFCheckout<CR>
nmap <silent> <leader>gL :FZFGitLog<CR>
nmap <silent> ycl :.GBrowse!<CR>
nmap <silent> ycf :GBrowse!<CR>

cnoremap <expr> <c-x><c-x> "\<C-r>=fzf#run({ 'source': 'git log', 'window': { 'width': 0.9, 'height': 0.6 } })\<CR>"

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

let g:fzf_files_options = '-e --preview "bat --color=always -p {} 2> /dev/null"'
" let g:fzf_preview_window = 'right:80%'
let g:fzf_buffers_jump = 1

