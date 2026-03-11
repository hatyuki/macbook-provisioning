autoload -Uz has.command has.function

# ==============================================================================
# antigravity
# ==============================================================================
path+=("${HOME}/.antigravity/antigravity/bin"(N-/))


# ==============================================================================
# anyframe
# ==============================================================================
autoload -Uz anyframe-action-execute

if has.function anyframe-action-execute; then
    bindkey "^G^G" anyframe-widget-cd-ghq-repository
    bindkey "^G^P" anyframe-widget-put-ghq-repository
    bindkey "^G^W" anyframe-widget-select-widget
    bindkey "^K" anyframe-widget-kill
    bindkey "^R" anyframe-widget-put-history
    bindkey "^G^L" anyframe-widget-insert-git-ls-files
fi


# ==============================================================================
# colima
# ==============================================================================
has.command colima && eval "$(colima completion zsh)"


# ==============================================================================
# direnv
# ==============================================================================
has.command direnv && eval "$(direnv hook zsh)"


# ==============================================================================
# go
# ==============================================================================
if has.command go; then
    export GOPATH="${HOME}/.go"
    path+=("${GOPATH}/bin"(N-/))
fi


# ==============================================================================
# Homebrew Cask
# ==============================================================================
has.command brew && export HOMEBREW_CASK_OPTS="--appdir=~/Applications"


# ==============================================================================
# mise
# ==============================================================================
has.command mise && eval "$(mise activate zsh --shims)"


# ==============================================================================
# op (1password)
# ==============================================================================
if has.command op; then
    eval "$(op completion zsh)" && compdef _op op
    export SSH_AUTH_SOCK="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi


# ==============================================================================
# Terraform
# ==============================================================================
if has.command terraform; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C terraform terraform

    export TF_PLUGIN_CACHE_DIR="${HOME}/.terraform.d/plugin-cache"
    [[ ! -d  "${TF_PLUGIN_CACHE_DIR}" ]] && mkdir -p "${TF_PLUGIN_CACHE_DIR}"
fi


# ==============================================================================
# yazi
# ==============================================================================
if has.command yazi; then
    autoload -Uz y
fi

