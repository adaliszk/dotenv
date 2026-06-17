{
  description = "System Profiles & Configurations by AdaLiszk, btw";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flakeUtils.url = "github:numtide/flake-utils";
    systemManager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      systemManager,
      flakeUtils,
      nixGL,
      ...
    }:
    flakeUtils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          inherit system;
        };
        systemNames = map (pkgs.lib.removeSuffix ".nix") (builtins.attrNames (builtins.readDir ./systems));
        profileNames = map (pkgs.lib.removeSuffix ".nix") (builtins.attrNames (builtins.readDir ./profiles));
        nixGLWrap = nixGL: pkg: pkgs.symlinkJoin {
          name = "${pkg.pname or pkg.name}-nixgl";
          paths = [ pkg ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            for bin in $out/bin/*; do
              if [ -L "$bin" ]; then
                tgt=$(readlink -f "$bin"); rm "$bin"
                makeWrapper ${nixGL}/bin/nixGL "$bin" --add-flags "$tgt"
              fi
            done
          '';
        };
        importNix = dir: name: import (dir + "/${name}.nix") { inherit pkgs system systemManager nixgl nixGLWrap; };
        profiles = pkgs.lib.genAttrs profileNames (importNix ./profiles);
      in
      {
        systemConfigs = lib.genAttrs systemNames (name: (importNix ./systems name).system);
        packages = profiles // { default = profiles.essentials; };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            dprint
            nixfmt
            nufmt
          ];
        };
      }
    );
}
