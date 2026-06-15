{ pkgs, ... }:

pkgs.buildEnv {
  name = "hyprland";
  paths = with pkgs; [
    hyprpaper
    hypridle
    hyprsunset
    hyprshutdown
    hyprlauncher
    hyprlock
    ironbar
  ];
}
