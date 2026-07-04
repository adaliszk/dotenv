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
    ollama-system
    lazyllama
    opencode
  ];
}
