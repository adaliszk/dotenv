{ pkgs, system, ... }:

let
  teams-for-system = if pkgs.lib.hasSuffix "linux" system then pkgs.teams-for-linux else pkgs.teams;
in
pkgs.buildEnv {
  name = "messaging";
  paths = with pkgs; [
    discord
    caprine
    whatsie
    teams-for-system
  ];
}
