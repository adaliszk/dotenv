{
  pkgs,
  systemManager,
  system,
  ...
}@args:

rec {
  config = {
    nixpkgs.hostPlatform = system;
    nix.settings.trusted-users = "root @wheel";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system = systemManager.lib.makeSystemConfig {
    modules = [ config ];
  };
}
