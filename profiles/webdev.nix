{ pkgs, system, jetbrainsPlugins, ... }:

let
  webstorm = jetbrainsPlugins.lib.${system}.buildIdeWithPlugins
  pkgs.jetbrains "webstorm" [
    "net.codestats.plugin.atom.intellij"
    "com.chylex.intellij.inspectionlens"
    "com.clutcher.comments_highlighter"
    "indent-rainbow.indent-rainbow"
    "lermitage.intellij.extra.icons"
    "deno"
  ];
in
pkgs.buildEnv {
  name = "webdev";
  paths = with pkgs; [
    webstorm
    deno
  ];
}
