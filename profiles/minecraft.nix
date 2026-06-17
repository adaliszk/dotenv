{ pkgs, system, jetbrainsPlugins, ... }:

let
  idea = jetbrainsPlugins.lib.${system}.buildIdeWithPlugins
  pkgs.jetbrains "idea" [
    "net.codestats.plugin.atom.intellij"
    "com.chylex.intellij.inspectionlens"
    "com.clutcher.comments_highlighter"
    "indent-rainbow.indent-rainbow"
    "lermitage.intellij.extra.icons"
  ];
in
pkgs.buildEnv {
  name = "minecraft";
  paths = with pkgs; [
    pandora-launcher
    modrinth-app
    idea
  ];
}
