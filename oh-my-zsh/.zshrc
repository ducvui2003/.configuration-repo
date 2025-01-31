if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#Zinit
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
zinit light lukechilds/zsh-nvm
zinit light ogozu/zsh-eza

autoload -U  compinit && compinit

export ZSH="$HOME/.oh-my-zsh"

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

export EZA_USE_ICONS=1           # Enable icons in file listings
export EZA_COLOR=1               # Enable color output in listings
export EZA_DEFAULT_FORMAT='long' # Use long format by default

plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# sdkman
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$JAVA_HOME/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Alias
alias nzsh='nvim ~/.zshrc'
alias cl='clear'
alias oh='cd ~ || echo "Welcome to home"'
alias sz='source ~/.zshrc'
alias nwt='nano -l ~/.wezterm.lua'
alias sv="source ~/.config/nvim/init.lua"
alias nnvim="nvim  ~/.config/nvim/init.lua"
## Docker
alias dk="sudo systemctl enable docker "
alias dkmysql="sudo docker start mysql-container "
alias dkredis="sudo docker start redis "
alias dkmongo="sudo docker start mongodb_container "
alias backup_brew="brew bundle dump --file=~/Brewfile --force --no-vscode || echo 'backup success' "

PATH=~/.console-ninja/.bin:$PATH

