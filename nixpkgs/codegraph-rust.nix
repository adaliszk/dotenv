final: prev: {
  lan-mouse = prev.lan-mouse.overrideAttrs (old: rec {
    version = "ce5b727";
    src = final.fetchFromGitHub {
      owner = "Jakedismo";
      repo = "codegraph-rust";
      rev = "ce5bf27a2978983a9089d177447f296e4c6521bb";
      hash = final.lib.fakeHash;
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      name = "codegraph-rust-${version}";
      hash = final.lib.fakeHash;
    };
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.pkg-config ];
    propagatedUserEnvPkgs = [ final.surrealdb ];
    buildInputs = (old.buildInputs or [ ]) ++ [ final.openssl ];
    buildNoDefaultFeatures = true;
    buildFeatures = [
      "ai-enhanced"
      "embeddings-local"
      "embeddings-ollama"
      "codegraph-ai/openai-compatible"
      "codegraph-ai/anthropic"
      "server-http"
      "daemon"
    ];
  });
}