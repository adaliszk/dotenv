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
      tuigreet # FUTURE: Switch after https://github.com/hyprwm/hyprlock/pull/731 merged
    ];
    environment.etc."greetd/config.toml".text = ''
      [terminal]
        vt = 1
      [default_session]
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --time --cmd 'uwsm start hyprland.desktop'"
        user = "greeter"
    '';
  };
in
{
  inherit config;
  system = systemManager.lib.makeSystemConfig {
    modules = [
      (import ./root.nix args).config
      (import ./minimal.nix args).config
      (import ./desktop.nix args).config
      config
    ];
  };
}
