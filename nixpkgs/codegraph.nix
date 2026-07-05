final: prev: {
  codegraph = final.rustPlatform.buildRustPackage rec {
    pname = "codegraph";
    version = "ce5b727";

    src = final.fetchFromGitHub {
      owner = "Jakedismo";
      repo = "codegraph-rust";
      rev = "ce5bf27a2978983a9089d177447f296e4c6521bb";
      hash = "sha256-iq2hBYOC8utpSqvBIbfNNYwth6bITfGBnGEEVt4HloY=";
    };

    propagatedUserEnvPkgs =  with final; [ surrealdb ];
    nativeBuildInputs = with final; [ pkg-config ];
    buildInputs = with final; [ openssl ];

    cargoHash = "sha256-QnpZeAMkYkpdt0Ql62rCQ0eNzfl97JUUt+Vhb78mJIo=";
    cargoBuildFlags = [ "--workspace" ];
    cargoCheckFlags = [ "--workspace" ];
    buildFeatures = [
      "codegraph-mcp-server/embeddings-ollama"
      "codegraph-mcp-server/server-http"
    ];
    doCheck = false;

    meta = with final.lib; {
      description = "Code knowledge graph MCP server with SurrealDB backend";
      homepage = "https://github.com/Jakedismo/codegraph-rust";
      license = licenses.mit;
      mainProgram = "codegraph";
    };
  };
}
