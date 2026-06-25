{ pkgs, ... }:

pkgs.buildEnv {
  name = "hyprland";
  paths = with pkgs; [
    lan-mouse
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
