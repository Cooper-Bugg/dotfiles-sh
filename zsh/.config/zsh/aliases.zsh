# eza replaces ls
alias ls='eza --icons'
alias ll='eza -lh --icons --git'
alias la='eza -lah --icons --git'
alias tree='eza --tree --icons'

# bat replaces cat
alias cat='bat'

# fd replaces find
alias find='fd'

# ripgrep replaces grep
alias grep='rg'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'

# git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# editor
alias v='nvim'
alias vcpp='nvim +Neotree'

# system shortcuts
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacre='sudo pacman -Rns'
alias pacse='pacman -Ss'
alias yayup='yay -Syu'
alias yayin='yay -S'

# quick config edits
alias hyprconf='vim ~/.config/hypr/hyprland.lua'
alias zshconf='vim ~/.config/zsh/.zshrc'
alias aliasconf='vim ~/.config/zsh/aliases.zsh'
