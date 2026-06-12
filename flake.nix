{
  description = "Nix Profiles by AdaLiszk, btw";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        profiles = builtins.attrNames (builtins.readDir ./profiles);
        importProfile = name: import (./profiles + "/${name}.nix") { inherit pkgs; };
        paths = builtins.listToAttrs (map (name: {
          inherit name;
          value = importProfile name;
        }) profiles);
      in {
        packages = builtins.listToAttrs (map (name: {
          inherit name;
          value = pkgs.buildEnv {
            name = name;
            paths = paths.${name};
          };
        }) profiles) // {
          everything = pkgs.buildEnv {
            name = "default";
            paths = builtins.concatLists (builtins.attrValues profiles);
          };
        };
        defaultPackage = self.packages.everything;
      }
    );
}
