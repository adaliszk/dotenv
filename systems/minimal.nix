{
  pkgs,
  systemManager,
  system,
  ...
}@args:

rec {
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
      (import ./root.nix args).config
      config
    ];
  };
}
