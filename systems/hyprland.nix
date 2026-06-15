{
  pkgs,
  systemManager,
  system,
  ...
}@args:

let
  fontEnv = pkgs.buildEnv {
    name = "system-fonts";
    paths = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.commit-mono
      nerd-fonts.arimo
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      inter
    ];
  };
in
{
  config = {
    nixpkgs.hostPlatform = system;
    environment.systemPackages = with pkgs; [
      tuigreet # FUTURE: Switch when https://github.com/hyprwm/hyprlock/pull/731
    ];
    environment.etc."fonts/nix".source = "${fontEnv}/share/fonts";
    environment.etc."fonts/conf.d/20-defaults.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias><family>sans-serif</family><prefer><family>Inter</family></prefer></alias>
        <alias><family>serif</family><prefer><family>Noto Serif</family></prefer></alias>
        <alias><family>monospace</family><prefer><family>CommitMono Nerd Font</family></prefer></alias>
      </fontconfig>
    '';
    environment.etc."greetd/config.toml".text = ''
      [terminal]
        vt = 1
      [default_session]
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --time --cmd start-hyprland"
        user = "greeter"
    '';
  };
  system = systemManager.lib.makeSystemConfig {
    modules = [
      (import ./root.nix args).config
      (import ./minimal.nix args).config
      config
    ];
  };
}
