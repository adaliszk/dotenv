{ pkgs, ... }:

let
  ollama-system = pkgs.writeShellApplication {
    name = "ollama";
     runtimeInputs = with pkgs; [
      ollama-rocm
      ollama-cpu
    ];
    text = ''
      if [ -e /dev/kfd ]; then
        exec ${pkgs.ollama-rocm}/bin/ollama "$@"
      else
        exec ${pkgs.ollama-cpu}/bin/ollama "$@"
      fi
    '';
  };
in
pkgs.buildEnv {
  name = "agentdev";
  paths = with pkgs; [
    opencode
    opencode-claude-auth
    opencode-desktop
    claude-code
    claude-monitor
    ollama-system
    gollama
    python315
    python3Packages.huggingface-hub
    python3Packages.hf-transfer
    aria2
  ];
}
