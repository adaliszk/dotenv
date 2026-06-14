{
  pkgs,
  systemManager,
  system,
  ...
}@args:

let
  greetCommand = pkgs.writeShellScript "tuigreet" ''
    ${pkgs.tuigreet}/bin/tuigreet \
      --remember \
      --time \
      --cmd ${pkgs.hyprland}/bin/start-hyprland \
      &> /tmp/start-hyprland.log
  '';
  config = {
    nixpkgs.hostPlatform = system;
    environment.systemPackages = with pkgs; [
      hyprland
      tuigreet # FUTURE: Switch when https://github.com/hyprwm/hyprlock/pull/731
    ];

    environment.etc."greetd/config.toml".text = ''
      [terminal]
        vt = 1
      [default_session]
        command = "${greetCommand}"
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
      config
    ];
  };
}
