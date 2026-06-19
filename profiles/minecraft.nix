{
  pkgs,
  jetbrainsPlugins,
  ...
}:

let
  idea = jetbrainsPlugins.lib.buildIdeWithPlugins pkgs "idea" [
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
