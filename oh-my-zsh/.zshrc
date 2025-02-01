if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# P10K
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions


# asdf
. "$(brew --prefix asdf)/libexec/asdf.sh"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

autoload -U  compinit && compinit

export ZSH="$HOME/.oh-my-zsh"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export JAVA_HOME="$HOME/.asdf/plugins/java/set-java-home.zsh"
# Theme
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# History settings
HISTFILE=~/.zsh_history 
HISTSIZE=1000
SAVEHIST=1000
HIST_STAMPS="%y/%m/%d %T"

plugins=(git 
        docker 
        docker-compose asdf)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$JAVA_HOME/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Alias
alias nzsh='nvim ~/.zshrc'
alias cl='clear'
alias oh='cd ~ || echo "Welcome to home"'
alias sz='source ~/.zshrc'
alias nwt='nvim ~/.wezterm.lua'

# Nvim
alias sv="source ~/.config/nvim/init.lua"
alias nnvim="nvim  ~/.config/nvim/init.lua"

# Tmux
alias stmux="tmux source-file ~/.tmux.conf"
alias ntmux="nvim ~/.tmux.conf" 

## Docker
alias dk="sudo systemctl enable docker "
alias dkmysql="sudo docker start mysql-container "
alias dkredis="sudo docker start redis "
alias dkmongo="sudo docker start mongodb_container "
alias backup_brew="brew bundle dump --file=~/Brewfile --force --no-vscode || echo 'backup success' "

## Eza
alias ls='eza --icons ' # Basic replacement for ls with eza --icons 
alias l='eza --icons  --long -bF' # Extended details with binary sizes and type indicators
alias ll='eza --icons  --long -a' # Long format, including hidden files
alias llm='eza --icons  --long -a --sort=modified' # Long format, including hidden files, sorted by modification date
alias la='eza --icons  -a --group-directories-first' # Show all files, with directories listed first
alias lx='eza --icons  -a --group-directories-first --extended' # Show all files and extended attributes, directories first
alias tree='eza --icons  --tree' # Tree view
alias lS='eza --icons  --oneline' # Display one entry per line

# new aliases than exa-zsh
alias lT='eza --tree --long' # Tree view with extended details
alias lr='eza --recurse --all' # Recursively list all files, including hidden ones
alias lg='eza --grid --color=always' # Display entries as a grid with color
alias ld='eza --only-dirs' # List only directories
alias lf='eza --only-files' # List only files
alias lC='eza --color-scale=size --long' # Use color scale based on file size
alias li='eza --icons=always --grid' # Display with icons in grid format
alias lh='eza --hyperlink --all' # Display all entries as hyperlinks
alias lX='eza --across' # Sort the grid across, rather than downwards
alias lt='eza --long --sort=type' # Sort by file type in long format
alias lsize='eza --long --sort=size' # Sort by size in long format
alias lmod='eza --long --modified --sort=modified' # Sort by modification date in long format, using the modified timestamp

# Advanced filtering and display options
alias ldepth='eza --level=2' # Limit recursion depth to 2
alias lignore='eza --git-ignore' # Ignore files mentioned in .gitignore
alias lcontext='eza --long --context' # Show security context
PATH=~/.console-ninja/.bin:$PATH

