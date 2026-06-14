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

    environment.etc."pam.d/greetd".text = ''
      auth      include   system-local-login
      account   include   system-local-login
      session   include   system-local-login
      password  include   system-local-login
    '';

    systemd.services.greetd = {
      enable = true;
      wantedBy = [ "system-manager.target" ];
      after = [
        "systemd-user-sessions.service"
        "getty@tty1.service"
      ];
      conflicts = [ "getty@tty1.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.greetd}/bin/greetd";
        Restart = "always";
        StandardInput = "tty";
        TTYPath = "/dev/tty1";
        TTYReset = true;
        TTYVHangup = true;
      };
    };
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
