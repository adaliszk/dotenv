{
  description = "System Profiles & Configurations by AdaLiszk, btw";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flakeUtils.url = "github:numtide/flake-utils";
    systemManager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      systemManager,
      flakeUtils,
      ...
    }:
    flakeUtils.lib.eachDefaultSystem (
      system:
      let
        lib = nixpkgs.lib;
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          inherit system;
        };
        systemNames = map (lib.removeSuffix ".nix") (builtins.attrNames (builtins.readDir ./systems));
        profileNames = map (lib.removeSuffix ".nix") (builtins.attrNames (builtins.readDir ./profiles));
        importNix = dir: name: import (dir + "/${name}.nix") { inherit pkgs system systemManager; };
        gitHooksDir = pkgs.linkFarm "git-hooks" [
          {
            name = "pre-commit";
            path = pkgs.writeShellScript "pre-commit" ''
              dprint fmt --staged
            '';
          }
        ];
      in
      {
        systemConfigs = lib.genAttrs systemNames (name: (importNix ./systems name).system);
        packages = lib.genAttrs profileNames (importNix ./profiles);
        defaultPackage = self.packages.essentials;

        devShells.default = pkgs.mkShell {
          shellHook = ''
            git config --local core.hooksPath ${gitHooksDir}
          '';
          packages = with pkgs; [
            dprint
            nixfmt
            nufmt
          ];
        };
      }
    );
}
