{
  pkgs,
  system,
  systemManager,
  ...
}:

{
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

  system = systemManager.lib.makeSystemConfig {
    modules = [
      ./root.nix
      ./minimal.nix
    ];
  };
}
