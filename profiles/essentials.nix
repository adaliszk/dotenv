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
    text = ''
      PRESET="''${1:?Usage: system-switch <flake-ref>}"
      system-manager switch --sudo --flake "$PRESET"
    '';
  };
in
pkgs.buildEnv {
  name = "essentials";
  paths = with pkgs; [
    systemManager.packages.${system}.default
    systemSwitch
  ];
}
