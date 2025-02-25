{
  description = "System Profiles by AdaLiszk, btw";

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
        profiles = import ./profiles/default.nix;
        importProfile = name: import (./profiles + "/pkgs-${name}.nix") { inherit pkgs; };
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
            name = "full-env";
            paths = builtins.concatLists (builtins.attrValues profiles);
          };
        };
        defaultPackage = self.packages.everything;
      }
    );
}