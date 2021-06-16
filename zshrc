#!/bin/sh

export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if [ -x "$(command -v fd)" ]; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
else
  export FZF_DEFAULT_COMMAND='find * -type f'
fi

[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'
if [ -x ~/.config/nvim/plug/fzf.vim/bin/preview.rb ]; then
  export FZF_CTRL_T_OPTS="--preview '~/.config/nvim/plug/fzf.vim/bin/preview.rb {} | head -200'"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -n $TMUX ]; then
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
fi

_fzf_recent_branches() {
  git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | fzf
}

alias gcor='git checkout $(_fzf_recent_branches)'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gitv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%an, %cr"'
alias gitme='git log --author="$(git config user.name)"'
alias opentorrent='peerflix --vlc -n -d --list '

export EDITOR=nvim
#
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export TERM=xterm-256color

# local node_modules
export PATH=./node_modules/.bin:$PATH


if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if [ -d "$HOME/.yarn" ]; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d "$HOME/.cargo" ]; then
  export PATH=$PATH:$HOME/.cargo/bin
fi

if [ -d "$HOME/.config/nvim/bin" ]; then
  export PATH=$PATH:$HOME/.config/nvim/bin
fi

export CFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"

# c - browse chrome history
c() {
  local cols sep
  export cols=$(( COLUMNS / 3 ))
  export sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select title, url from urls order by last_visit_time desc" |
  ruby -ne '
    cols = ENV["cols"].to_i
    title, url = $_.split(ENV["sep"])
    len = 0
    puts "\x1b[36m" + title.each_char.take_while { |e|
      if len < cols
        len += e =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/ ? 2 : 1
      end
    }.join + " " * (2 + cols - len) + "\x1b[m" + url' |
  fzf --ansi --multi --no-hscroll --tiebreak=index |
  sed 's#.*\(https*://\)#\1#' | xargs open
}

# Git autocompletion
autoload -Uz compinit
compinit

# Git prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' %F{11}[⎇ %b]%f'

# Emacs style bindings
bindkey -e

PS1='%F{15}%n%f@%F{9}%m%f:%~${vcs_info_msg_0_}'$'\n'"$ "

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
