{ pkgs, ... }:

pkgs.buildEnv {
  name = "webdev";
  paths = with pkgs; [
    jetbrains.webstorm
    deno
  ];
}
