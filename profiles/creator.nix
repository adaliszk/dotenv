{ pkgs, system, ... }:

pkgs.buildEnv {
  name = "creator";
  paths = with pkgs; [
    affine
    davinci-resolve
    gimp
  ];
}
