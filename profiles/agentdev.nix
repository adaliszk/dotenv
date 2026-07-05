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
  llama-turboquant-system = pkgs.writeShellApplication {
    name = "llama-turboquant-server";
    runtimeInputs = with pkgs; [
      llama-turboquant-rocm
      llama-turboquant-cpu
    ];
    text = ''
      if [ -e /dev/kfd ]; then
        exec ${pkgs.llama-turboquant-rocm}/bin/llama-server "$@"
      else
        exec ${pkgs.llama-turboquant-cpu}/bin/llama-server "$@"
      fi
    '';
  };
  agents-update = pkgs.writeShellApplication {
    name = "agents-update";
    runtimeInputs = with pkgs; [
      jq
      huggingface-hub
      ollama-system
      coreutils
    ];
    text = ''
      set -euo pipefail

      MANIFEST="''${1:-$HOME/AGENTS.models.json}"
      LLAMA_DEST="''${MODEL_DIR:-$HOME/.local/share/llama}"
      mkdir -p "$LLAMA_DEST"

      jq -c '.["llama"][]? // empty' "$MANIFEST" | while read -r entry; do
        repo=$(echo "$entry" | jq -r '.huggingface.repo // empty')
        tag=$(echo "$entry" | jq -r '.huggingface.tag // empty')
        file=$(echo "$entry" | jq -r '.huggingface.file // empty')
        name=$(echo "$entry" | jq -r '.name')
      
        echo "fetch(hf): $repo@$tag/$file -> $name.gguf"
        hf download "$repo" "$file" --revision "$tag" --local-dir "$LLAMA_DEST"
        mv "$LLAMA_DEST/$file" "$LLAMA_DEST/$name.gguf"
      done
      
      jq -c '.ollama[]? // empty' "$MANIFEST" | while read -r entry; do
        hfPath=$(echo "$entry" | jq -r '.huggingface // empty')
        name=$(echo "$entry" | jq -r '.name')
        model="hf.co/$hfPath"

        echo "fetch(ollama): $model -> $name"
        ollama pull "$model"
        ollama cp "$model" "$name"
        ollama rm "$model"
      done
    '';
  };
in
pkgs.buildEnv {
  name = "agentdev";
  paths = with pkgs; [
    ollama-system
    llama-turboquant-system
    agents-update
    opencode
  ];
}
