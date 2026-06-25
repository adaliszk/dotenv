final: prev: {
  lan-mouse = prev.lan-mouse.overrideAttrs (old: rec {
    version = "0.11.0";
    src = final.fetchFromGitHub {
      owner = "feschber";
      repo = "lan-mouse";
      tag = "v${version}";
      hash = final.lib.fakeHash;
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      name = "lan-mouse-${version}-vendor";
      hash = final.lib.fakeHash;
    };
  });
}