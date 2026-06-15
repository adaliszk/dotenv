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
      nushell
      git
      git-lfs
      fastfetch
      rsync
      stow
    ];
    environment.etc."shells".text = ''
      /bin/sh
      /bin/bash
      /usr/bin/sh
      /usr/bin/bash
      /usr/bin/systemd-home-fallback-shell
      ${pkgs.nushell}
    '';
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
