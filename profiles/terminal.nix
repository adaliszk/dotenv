{ pkgs, ... }:

pkgs.buildEnv {
  name = "terminal";
  paths = with pkgs; [
    nushell
    starship
    zoxide
    yazi
  ];
}
