{
  description = "nixGL bundled with a helper that wraps arbitrary packages to run under nixGL";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixGL, ... }:
    {
      inherit (nixGL) packages;

      overlays.default =
        final: prev:
        let
          runners = nixGL.packages.${final.system};
        in
        {
          inherit (runners)
            nixGLDefault
            nixGLIntel
            nixGLNvidia
            nixGLNvidiaBumblebee
            nixVulkanIntel
            nixVulkanNvidia
            ;
          wrapWithGL =
            nixGL: pkg:
            final.symlinkJoin {
              name = "${pkg.pname or pkg.name}-nixgl";
              paths = [ pkg ];
              nativeBuildInputs = [ final.makeWrapper ];
              postBuild = ''
                for bin in $out/bin/*; do
                  if [ -L "$bin" ]; then
                    tgt=$(readlink -f "$bin"); rm "$bin"
                    makeWrapper ${nixGL}/bin/nixGL "$bin" --add-flags "$tgt"
                  fi
                done
              '';
            };
        };
    };
}
