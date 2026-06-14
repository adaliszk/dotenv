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
      --cmd ${pkgs.hyprland}/bin/start-hyprland
  '';
in
rec {
  config = {
    nixpkgs.hostPlatform = system;
    environment.systemPackages = with pkgs; [
      hyprland
      tuigreet # FUTURE: Switch when https://github.com/hyprwm/hyprlock/pull/731
      greetd
    ];

    environment.etc."greetd/config.toml".text = ''
      [terminal]
        vt = 1
      [default_session]
        command = "${greetCommand}"
        user = "greeter"
    '';

    systemd.services.greetd = {
      enable = true;
      wantedBy = [ "system-manager.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.greetd}/bin/greetd";
        Restart = "always";
      };
    };
  };

  system = systemManager.lib.makeSystemConfig {
    modules = [
      (import ./root.nix args).config
      (import ./minimal.nix args).config
      config
    ];
  };
}
