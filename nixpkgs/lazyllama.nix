final: prev: {
  lazyllama = final.rustPlatform.buildRustPackage rec {
    pname = "lazyllama";
    version = "0.5.2";

    src = final.fetchCrate {
      inherit pname version;
      hash = "sha256-cXwcN3OeKI55tJJN7jUsoEDtUdMNwjqxA3Zt3F74/us=";
    };

    cargoHash = "sha256-pdWgEAmjLYGw6AiFC7i7pUhdcdgLOtlMiYowbz5A4gs=";

    nativeBuildInputs = [ final.pkg-config ];
    buildInputs = [ final.openssl ];
  };
}