# Plugin directory
PLUGIN_DIR="$HOME/.config/zsh/plugins"

# Function to load or install a plugin
function zsh_plugin() {
    local repo="$1"
    local name="${repo##*/}"
    local path="$PLUGIN_DIR/$name"

    if [[ ! -d "$path" ]]; then
        echo "Installing ZSH plugin: $name"
        /usr/bin/git clone "https://github.com/$repo.git" "$path" 
    fi

    source "$path/$name.plugin.zsh" 2>/dev/null || \
    source "$path/$name.zsh" 2>/dev/null || \
    source "$path/zsh-$name.plugin.zsh" 2>/dev/null
}

# Update all plugins
function zsh_plugin_update() {
    for dir in "$PLUGIN_DIR"/*/; do
        echo "Updating ${dir##*/}..."
        git -C "$dir" pull
    done
}

# Plugins
zsh_plugin "zsh-users/zsh-autosuggestions"
zsh_plugin "zsh-users/zsh-syntax-highlighting"
zsh_plugin "zsh-users/zsh-history-substring-search"
zsh_plugin "jeffreytse/zsh-vi-mode"
