alias dbl='sudo docker build'
alias dcin='sudo docker container inspect'
alias dcls='sudo docker container ls'
alias dclsa='sudo docker container ls -a'
alias dib='sudo docker image build'
alias dii='sudo docker image inspect'
alias dils='sudo docker image ls'
alias dipu='sudo docker image push'
alias dipru='sudo docker image prune -a'
alias dirm='sudo docker image rm'
alias dit='sudo docker image tag'
alias dlo='sudo docker container logs'
alias dnc='sudo docker network create'
alias dncn='sudo docker network connect'
alias dndcn='sudo docker network disconnect'
alias dni='sudo docker network inspect'
alias dnls='sudo docker network ls'
alias dnrm='sudo docker network rm'
alias dpo='sudo docker container port'
alias dps='sudo docker ps'
alias dpsa='sudo docker ps -a'
alias dpu='sudo docker pull'
alias dr='sudo docker container run'
alias drit='sudo docker container run -it'
alias drm='sudo docker container rm'
alias 'drm!'='sudo docker container rm -f'
alias dst='sudo docker container start'
alias drs='sudo docker container restart'
alias dsta='sudo docker stop $(docker ps -q)'  # This may require sudo for docker stop command
alias dstp='sudo docker container stop'
alias dtop='sudo docker top'
alias dvi='sudo docker volume inspect'
alias dvls='sudo docker volume ls'
alias dvprune='sudo docker volume prune'
alias dxc='sudo docker container exec'
alias dxcit='sudo docker container exec -it'

if (( ! $+commands[docker] )); then
  return
fi

# Standardized $0 handling
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `docker`. Otherwise, compinit will have already done that.
if [[ ! -f "$ZSH_CACHE_DIR/completions/_docker" ]]; then
  typeset -g -A _comps
  autoload -Uz _docker
  _comps[docker]=_docker
fi

{
  # `docker completion` is only available from 23.0.0 on
  # docker version returns `Docker version 24.0.2, build cb74dfcd85`
  # with `s:,:` remove the comma after the version, and select third word of it
  if zstyle -t ':omz:plugins:docker' legacy-completion || \
    ! is-at-least 23.0.0 ${${(s:,:z)"$(command docker --version)"}[3]}; then
        command cp "${0:h}/completions/_docker" "$ZSH_CACHE_DIR/completions/_docker"
      else
        command docker completion zsh | tee "$ZSH_CACHE_DIR/completions/_docker" > /dev/null
  fi
} &|
