{ pkgs, ... }:

pkgs.buildEnv {
  name = "hyprland";
  paths = with pkgs; [
    hyprsunset
    hyprshutdown
    hyprlauncher
    hyprlock
    ashell
  ];
}
