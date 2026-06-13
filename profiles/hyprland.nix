{ pkgs, ... }:

pkgs.buildEnv {
  name = "hyprland";
  paths = with pkgs; [
    hyprland
    hyprsunset
    hyprshutdown
    hyprlauncher
    hyprlock
    ashell
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.commit-mono
    nerd-fonts.space-mono
  ];
}
