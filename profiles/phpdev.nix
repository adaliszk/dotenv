{
  pkgs,
  jetbrainsPlugins,
  ...
}:

let
  phpstorm = jetbrainsPlugins.lib.buildIdeWithPlugins pkgs "phpstorm" [
    "net.codestats.plugin.atom.intellij"
    "com.chylex.intellij.inspectionlens"
    "com.clutcher.comments_highlighter"
    "indent-rainbow.indent-rainbow"
    "lermitage.intellij.extra.icons"
    "deno"
  ];
in
pkgs.buildEnv {
  name = "phpdev";
  paths = with pkgs; [
    phpstorm
    php85
    php85Packages.composer
    phpstan
    mago
  ];
}
