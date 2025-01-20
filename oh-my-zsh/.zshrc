if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet


#Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# P10K
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

autoload -U  compinit && compinit

export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# History settings
HISTFILE=~/.zsh_history 
HISTSIZE=1000
SAVEHIST=1000
HIST_STAMPS="%y/%m/%d %T"

plugins=(git docker)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# nvm
  export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion


# sdkman
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$JAVA_HOME/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Alias
alias nzsh='nano -l ~/.zshrc'
alias cl='clear'
alias oh='cd ~ || echo "Welcome to home"'
alias sz='source ~/.zshrc'
alias nwt='nano -l ~/.wezterm.lua'
alias sv="source ~/.config/nvim/init.lua"
alias nnvim="nano -l ~/.config/nvim/init.lua"
## Docker
alias dk="sudo systemctl enable docker "
alias dkmysql="sudo docker start mysql "
alias dkredis="sudo docker start redis "
alias dkmongo="sudo docker start mongodb_container "
alias backup_brew="brew bundle dump --file=~/Brewfile --force --vs-code"

PATH=~/.console-ninja/.bin:$PATH

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
