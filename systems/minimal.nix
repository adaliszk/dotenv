{
  pkgs,
  systemManager,
  system,
  ...
}@args:

let
  config = {
    nixpkgs.hostPlatform = system;
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      fastfetch
      rsync
      stow
    ];
  };
in
{
  inherit config;
  system = systemManager.lib.makeSystemConfig {
    modules = [
      (import ./root.nix args).config
      config
    ];
  };
}
