function zvm_after_init() {
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh

    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    bindkey '^E' end-of-line
    bindkey '^A' beginning-of-line
    bindkey '^[f' forward-word
    bindkey '^[b' backward-word
}
