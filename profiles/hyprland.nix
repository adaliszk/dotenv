{ pkgs, ... }:

pkgs.buildEnv {
  name = "hyprland";
  paths = with pkgs; [
    # hyprland
    hyprpaper
    hypridle
    hyprsunset
    hyprshutdown
    hyprlock
    # hyprlauncher
    hyprpwcenter
    hyprcursor
    ironbar
    foot
  ];
}
