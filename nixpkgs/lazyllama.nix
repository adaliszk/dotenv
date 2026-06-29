final: prev: {
  lazyllama = final.rustPlatform.buildRustPackage rec {
    pname = "lazyllama";
    version = "0.5.2";

    src = final.fetchCrate {
      inherit pname version;
      hash = final.lib.fakeHash;
    };

    cargoHash = final.lib.fakeHash;
  };
}