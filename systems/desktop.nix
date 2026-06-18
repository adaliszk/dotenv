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
  config = {
    nixpkgs.hostPlatform = system;
    # FUTURE: Use /usr after https://github.com/numtide/system-manager/issues/301 resolved
    environment.etc."fonts/nix".source = "${fontEnv}/share/fonts";
    environment.etc."fonts/conf.d/00-nix-fonts.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <dir>/etc/fonts/nix</dir>
      </fontconfig>
    '';
    environment.etc."fonts/conf.d/20-defaults.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias><family>monospace</family><prefer><family>CommitMono Nerd Font</family></prefer></alias>
        <alias><family>sans-serif</family><prefer><family>Inter</family></prefer></alias>
        <alias><family>serif</family><prefer><family>Noto Serif</family></prefer></alias>
      </fontconfig>
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
