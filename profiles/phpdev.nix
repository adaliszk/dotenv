{ pkgs, ... }:

pkgs.buildEnv {
  name = "phpdev";
  paths = with pkgs; [
    jetbrains.phpstorm
    php85
    php85Packages.composer
    phpstan
    mago
  ];
}
