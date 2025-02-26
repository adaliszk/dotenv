{ pkgs }: with pkgs;

[
  nushell
  nushellPlugins.query
  nushellPlugins.units
  nushellPlugins.skim
  nushellPlugins.highlight
  nufmt
  stow
  git
  git-lfs
  openssh
  rsync
  neovim
  kubectl
  k9s
  proto
  moon
  docker
  docker-buildx
  docker-sync
  docker-ls
  docker-gc
  lazydocker
]
