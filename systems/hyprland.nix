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
      tuigreet # FUTURE: Switch when https://github.com/hyprwm/hyprlock/pull/731
      foot
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.commit-mono
      nerd-fonts.arimo
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      liberation_ttf
      liberation-sans-narrow
      inter
    ];
    environment.etc."fonts/conf.d/50-default-fonts.conf".text = ''
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
