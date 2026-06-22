{
  pkgs,
  systemManager,
  system,
  ...
}:

let
  systemSwitch = pkgs.writeShellApplication {
    name = "system-switch";
    runtimeInputs = [ systemManager.packages.${system}.default ];
    text = ''system-manager switch --sudo --flake "$@"'';
  };
  configUpdate = pkgs.writeShellApplication {
    name = "config-update";
    runtimeInputs = with pkgs; [
      git
      nix
      jq
      stow
    ];
    text = ''
      set -euo pipefail
      REPO="''${SYSTEM_REPO:-https://github.com/adaliszk/system}"
      ROOT="''${SYSTEM_DIR:-$HOME/.system}"

      echo "> Checking $ROOT for $REPO state"
      if [ -d "$ROOT/.git" ]; then
        git -C "$ROOT" pull --ff-only
      else
        git clone "$REPO" "$ROOT"
      fi

      echo "> Extracting nix profile names"
      mapfile -t PROFILES < <(nix profile list --json | jq -r '.elements | keys[]')

      echo "> Remove broken symlinks"
      find "$HOME" -xtype l -delete

      echo "> Stow configurations"
      for NAME in "''${PROFILES[@]}"; do
        [ -d "$ROOT/configs/$NAME" ] || continue
        stow --no-folding -d "$ROOT/configs" -t "$HOME" -R "$NAME"
      done
    '';
  };
in
pkgs.buildEnv {
  name = "essentials";
  paths = with pkgs; [
    systemManager.packages.${system}.default
    systemSwitch
    configUpdate
    proto
  ];
}
