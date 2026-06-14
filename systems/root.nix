{
  pkgs,
  systemManager,
  system,
  ...
}:

let
  config = {
    system-manager.allowAnyDistro = true;
    nixpkgs.hostPlatform = system;
    nix.settings.trusted-users = "root @wheel";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    environment.systemPackages = with pkgs; [
      openssh
    ];
  };
in
{
  inherit config;
  system = systemManager.lib.makeSystemConfig {
    modules = [ config ];
  };
}
