{ pkgs, system, ... }:

pkgs.buildEnv {
  name = "minecraft";
  paths = with pkgs; [
    pandora-launcher
    modrinth-app
    jetbrains.idea
  ];
}
