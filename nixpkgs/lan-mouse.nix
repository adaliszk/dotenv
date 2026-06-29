final: prev: {
  lan-mouse = prev.lan-mouse.overrideAttrs (old: rec {
    version = "0.11.0";
    src = final.fetchFromGitHub {
      owner = "feschber";
      repo = "lan-mouse";
      tag = "v${version}";
      hash = "sha256-6EqA9WfiukOymUT4FkNdMvzmFKByW0LLoI/9sv4TzBU=";
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      name = "lan-mouse-${version}-vendor";
      hash = "sha256-Lxs0qWvNAv4KCeJ+cDBYBzwlbJfQJshcxPRdg9w0szc=";
    };
    # 0.11.0 switched to shadow-rs which requires build.rs to set OUT_DIR;
    # the base package removes build.rs for 0.10.0's GIT_DESCRIBE approach.
    prePatch = "";
    # Since my use-case us zero GUI on Wayland, a partial build is enough.
    buildNoDefaultFeatures = true;
    buildFeatures = [
      "layer_shell_capture"
      "libei_capture"
      "wlroots_emulation"
      "libei_emulation"
      "rdp_emulation"
    ];
  });
}
