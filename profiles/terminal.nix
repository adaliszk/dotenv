{ pkgs, ... }:

pkgs.buildEnv {
  name = "terminal";
  paths = with pkgs; [
    nushell
    starship
    zoxide
    yazi
    yaziPlugins.starship
    yaziPlugins.split-tabs
    yaziPlugins.wl-clipboard
    yaziPlugins.smart-paste
    yaziPlugins.piper
  ];
}
