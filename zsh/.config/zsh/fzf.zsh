# FZF -- Cyberpunk palette
export FZF_DEFAULT_OPTS="
    --height 40%
    --layout=reverse
    --border sharp
    --color=bg+:#141824,bg:#0a0d14,spinner:#f0b429,hl:#5a9fd4
    --color=fg:#c8d0e0,header:#5a9fd4,info:#f0b429,pointer:#f0b429
    --color=marker:#cc3333,fg+:#e0e8f0,prompt:#5a9fd4,hl+:#7ab8e0
    --color=border:#2d3550,label:#5a9fd4
    --prompt='❯ '
    --pointer='◆'
    --marker='◈'
"

# Ctrl+T: search files with bat preview
export FZF_CTRL_T_OPTS="
    --preview 'bat --color=always --style=numbers --line-range=:50 {}'
    --preview-window=right:50%:border-sharp
"

# Ctrl+R: history search
export FZF_CTRL_R_OPTS="
    --preview 'echo {}'
    --preview-window=down:3:wrap:border-sharp
"

# Alt+C: directory jump with tree preview
export FZF_ALT_C_OPTS="
    --preview 'eza --tree --color=always {} | head -50'
    --preview-window=right:50%:border-sharp
"
