#!/usr/bin/env zsh
# ==============================================================================
# NOTE: Loading order
#
#   1. /etc/zshenv
#   2. ${HOME}/.zshenv
#   3. /etc/zshprofile (skip)
#   4. ${HOME}/.zshprofile
#   5. ${HOME}/.zshrc
#   6. /etc/zlogin (skip)
#   7. ${HOME}/.zlogin
#
# SEE ALSO: http://qiita.com/muran001/items/7b104d33f5ea3f75353f
#
# ==============================================================================

# ==============================================================================
# TMUX
# ==============================================================================
if [[ -z "${INTELLIJ_ENVIRONMENT_READER:-}" ]]; then
  # JetBrains 系のターミナルで実行したくないものがあれば
  :
fi


# ==============================================================================
# Environment Variables
# ==============================================================================
# PATH / FPATH
typeset -gU path fpath
path+=(~/.local/bin(N/-) /opt/homebrew/{,s}bin(N-/))
fpath+=(~/.zsh/functions(N/-))

# Umask
umask 027

# EDITOR
if (command -v vim > /dev/null); then
    export EDITOR="vim"
elif (command -v vi > /dev/null); then
    export EDITOR="vi"
elif (command -v nano > /dev/null); then
    export EDITOR="nano"
fi

# PAGER
if (command -v lv > /dev/null); then
    export PAGER="lv"
    export LV="-c"
elif (command -v less > /dev/null); then
    export PAGER="less"
else
    export PAGER="more"
fi

# Locale & History
if [[ "${UID}" == 0 ]]; then # root user
    export LANG="C"
    export SAVEHIST=0
    unset HISTFILE
else
    export LANG="ja_JP.UTF-8"
    export HISTFILE="${HOME}/.zsh_history"
    export SAVEHIST=100000 # ファイルに保存する履歴数
fi

export LISTMAX=0      # 補完リストが多い場合に尋ねるか -1:尋ねない / 0:ウインドウから溢れるとき / 1~: 指定件数を超えるとき
export HISTSIZE=10000 # メモリに保存する履歴数


# ==============================================================================
# Prompt Settings
# ==============================================================================
autoload -Uz add-zsh-hook

export SPROMPT="Did you mean: %B%F{green}%r%f%b [(y)es/(N)o/(a)bort/(e)dit]: "
export PROMPT="%F{%(!.red.blue)}%~%f"$'\n'"(nopure) %F{%(?.magenta.red)}❯%f "
export PROMPT2="... %F{%(?.magenta.red)}❯%f "

__newline() {
  if [[ -z "${prompt_pure_state}" ]]; then
    echo
  fi
}

add-zsh-hook precmd __newline


# ==============================================================================
# Zsh Options (Behavior & History)
# ==============================================================================
# Pushd
setopt auto_pushd           # cd したら自動で pushd
setopt pushd_ignore_dups    # 重複する場合は pushd しない

# No Beep
setopt no_beep
setopt no_hist_beep
setopt no_list_beep

# Misc
setopt correct              # コマンドやファイル名のスペルチェック
setopt no_flow_control      # [^S] [^Q] 無効
setopt interactive_comments # コマンドラインでも '#' をコメントと認識する
setopt print_eight_bit      # マルチバイトの扱い

# History Behavior
setopt hist_ignore_all_dups  # 重複する History は記録しない
setopt hist_no_store         # history コマンドは履歴に含めない
setopt hist_reduce_blanks    # 余分なスペースを削除する
setopt inc_append_history    # HISTFILE は上書ではなく追記
setopt hist_ignore_space     # コマンドがスペースから始まったらヒストリに残さない
setopt hist_no_functions     # 関数定義はヒストリに残さない
setopt share_history         # ヒストリを共有する


# ==============================================================================
# Completion (Options & Styles)
# ==============================================================================
# Options
setopt auto_list            # 補完候補が複数ある (=曖昧な補完) 場合は候補をリストアップ
setopt auto_menu            # [TAB] 連打で補完
setopt complete_aliases     # alias されたコマンドでも補完
setopt complete_in_word     # 文字の途中の位置からでも補完
setopt list_packed          # 補完候補のリストをコンパクトに
setopt magic_equal_subst    # --opt= 以降の補完も有効に

# Styles
# setopt correct{,_all} 対策
export CORRECT_IGNORE="_*"      # _ から始まるコマンドを修正候補にしない
export CORRECT_IGNORE_FILE=".*" # . から始まるファイルを修正候補にしない

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path "${path[@]}"

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'


# ==============================================================================
# Key Bindings
# ==============================================================================
autoload -Uz edit-command-line up-line-or-beginning-search down-line-or-beginning-search

bindkey -d

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# コマンドラインを $EDITOR で編集
zle -N edit-command-line
bindkey '^T' edit-command-line

# 履歴検索
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search


# ==============================================================================
# Aliases
# ==============================================================================
if (command -v vim > /dev/null); then
    alias vi="vim"
fi

alias cp="nocorrect cp -i"
alias mv="nocorrect mv -i"
alias mkdir="nocorrect mkdir -p"

alias ls="ls -F --color"
alias la="ls -la"
alias ll="ls -lh"
alias rm="rm -i"
alias mkYmdir='mkdir $(date +%Y%m%d)'
alias grep="grep --color=auto"
alias tailf="tail -F"
alias checkip="curl checkip.amazonaws.com"


# ==============================================================================
# Initialize Completion
# ==============================================================================
autoload -Uz compinit && compinit -u


# ==============================================================================
# Run Sheldon
# ==============================================================================
if (command -v sheldon > /dev/null); then
  eval "$(sheldon source)"
elif [[ -e "${HOME}/.zsh/plugins" ]]; then
  while IFS= read -r plugin; do
    source "${plugin}"
  done < <(find "${HOME}/.zsh/plugins" -type f -name "*.zsh" | sort)
fi

if (command -v zprof > /dev/null); then
    zprof | less
fi

# vim:ft=zsh
