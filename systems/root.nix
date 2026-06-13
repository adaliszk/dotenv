{
  pkgs,
  systemManager,
  ...
}:

{
  config = {
    nixpkgs.hostPlatform = system;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system = systemManager.lib.makeSystemConfig {
    modules = [ ./root.nix ];
  };
}
