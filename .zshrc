# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Options
setopt PROMPT_SUBST
THEME_PROMPT_PREFIX=${THEME_PROMPT_PREFIX:-''}
THEME_VI_INS_MODE_SYMBOL=${THEME_VI_INS_MODE_SYMBOL:-'$'}
THEME_VI_CMD_MODE_SYMBOL=${THEME_VI_CMD_MODE_SYMBOL:-'λ'}

# Set symbol for the initial mode
THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"

# on keymap change, define the mode and redraw prompt
zle-keymap-select() {
    if [ "${KEYMAP}" = 'vicmd' ]; then
        THEME_VI_MODE_SYMBOL="${THEME_VI_CMD_MODE_SYMBOL}"
    else
        THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
    fi
    zle reset-prompt
}
zle -N zle-keymap-select

# reset to default mode at the end of line input reading
zle-line-finish() {
    THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode, you'd be prompted with CMD mode indicator
# while in fact you would be in INS mode.
# Fixed by catching SIGINT (C-c), set mode to INS and repropagate the SIGINT,
# so if anything else depends on it, we will not break it.
TRAPINT() {
    THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
    return $(( 128 + $1 ))
}

PROMPT='%F{magenta}[%F{yellow}%n%F{magenta}@%F{blue}%m%F{white}: %F{cyan}%1~ %F{magenta}]%F{yellow}%(?.%F{yellow}$THEME_VI_MODE_SYMBOL.%F{yellow}$THEME_VI_MODE_SYMBOL) %F{white}'

# save history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000

setopt CORRECTALL                # Try to correct the spelling of commands
setopt NOCASEGLOB                # Make command case insensitive
setopt AUTOCD AUTOPUSHD          # Change directories without cd
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Tab]}"       ]] && bindkey -- "${key[Tab]}"        reverse-menu-complete
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

# command for recommendations
source ~/.bin/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zmodload zsh/complist

bindkey '^f' down-line-or-select
bindkey '^j' down-line-or-history
bindkey '^k' up-line-or-history
bindkey '^h' history-incremental-search-backward

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# quick alias
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias py='python'

# replace original commands
alias cp='cp -riv'
alias mv='mv -iv'
alias mkdir='mkdir -vp'
alias du='du -h'
alias df='df -h'

# give terminal color
alias ip='ip -c=always'
alias ls='ls -a --color=always --group-directories-first'
alias ll='ls -la --color=always --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# quickly exit directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# archive extractor
ex() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# fzf change directory
fcd() {
    cd;
    file="$(find * ~/.config/ /run/media/ -type f | fzf --sort \
        --preview="dash ~/scripts/keybind/find_file/directory_preview.sh {}"\
        --preview-window="top,30%")"

    if [ $file != '' ]; then
        absolutedir=$(dirname $file)
        cd $absolutedir; clear; echo ""
        exa -al --icons --color=always --group-directories-first
    fi
}

# fzf open file
ff() {
    currentDir=$(pwd)
    cd;
    file="$(find * ~/.config/ /run/media/ -type f | fzf --sort \
        --preview="dash ~/scripts/keybind/find_file/file_preview.sh {}"\
        --preview-window="top,80%")"
    extension=$(echo ${file} | awk -F . '{print $NF}')
    extension=$(echo ${extension} | awk '{print tolower($0)}')

    if [ $file != '' ]; then
        cd $(dirname $file)
        file=$(basename $file)

        dash ~/scripts/general/open_file.sh $file

        if [[ $currentDir == $HOME ]]; then; exit
        else; cd $currentDir; fi
    fi
}

# fzf open current file
ffc() {
    currentDir=$(pwd)
    file="$(find . -type f | fzf --sort \
        --preview="dash ~/scripts/keybind/find_file/file_preview.sh {}"\
        --preview-window="top,80%")"

    if [ $file != '' ]; then
        cd $(dirname $file)
        file=$(basename $file)

        dash ~/scripts/general/open_file.sh $file

        if [[ $currentDir == $HOME ]]; then; exit
        else; cd $currentDir; fi
    fi
}

# ripgrep fzf
fg() {
    local file
    RG_PREFIX="rga --files-with-matches"
    file="$(FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
        fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}"\
        --phony -q "$1" \
        --bind "change:reload:$RG_PREFIX {q}" \
        --preview-window="top,80%:wrap")"
    vim "$file"
}

# Add color in manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[35m'
export LESS_TERMCAP_se=$'\E[36m'
export LESS_TERMCAP_so=$'\E[01;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#echo " $(fortune -n 20 -s) \n" "Time: $(uptime | sed 's/ //' | grep -o '^\S*') \n" "$(uptime --pretty | sed 's/up //') " | cowthink -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e default mutilated small three-eyes) -n
