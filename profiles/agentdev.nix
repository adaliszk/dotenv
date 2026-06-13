{ pkgs, ... }:

pkgs.buildEnv {
  name = "agentdev";
  paths = with pkgs; [
    opencode
    opencode-claude-auth
    opencode-desktop
    claude-code
    claude-monitor
  ];
}
