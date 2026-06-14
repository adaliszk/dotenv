{ pkgs, ... }:

pkgs.buildEnv {
  name = "terminal";
  paths = with pkgs; [
    tmux
    nushell
    starship
    zoxide
    ripgrep
    fd
    yazi
  ];
}
