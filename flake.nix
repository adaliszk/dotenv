{
  description = "System Profiles & Configurations by AdaLiszk, btw";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flakeUtils.url = "github:numtide/flake-utils";
    systemManager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jetbrainsPlugins = {
      url = "github:theCapypara/nix-jetbrains-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      systemManager,
      flakeUtils,
      nixgl,
      jetbrainsPlugins,
      ...
    }:
    flakeUtils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          inherit system;
        };
        nixglWrap =
          nixgl: pkg:
          pkgs.symlinkJoin {
            name = "${pkg.pname or pkg.name}-nixgl";
            paths = [ pkg ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              for bin in $out/bin/*; do
                if [ -L "$bin" ]; then
                  tgt=$(readlink -f "$bin"); rm "$bin"
                  makeWrapper ${nixgl}/bin/nixGL "$bin" --add-flags "$tgt"
                fi
              done
            '';
          };
        importNix =
          dir: name:
          import (dir + "/${name}.nix") {
            inherit
              pkgs
              system
              systemManager
              nixgl
              nixglWrap
              jetbrainsPlugins
              ;
          };
        systemNames = map (pkgs.lib.removeSuffix ".nix") (builtins.attrNames (builtins.readDir ./systems));
        systems = pkgs.lib.genAttrs systemNames (name: (importNix ./systems name).system);
        profileNames = map (pkgs.lib.removeSuffix ".nix") (
          builtins.attrNames (builtins.readDir ./profiles)
        );
        profiles = pkgs.lib.genAttrs profileNames (importNix ./profiles);
      in
      {
        systemConfigs = systems;
        packages = profiles // {
          default = profiles.essentials;
        };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            dprint
            nixfmt
            nufmt
            (pkgs.writeShellScriptBin "skills-update" ''
              set -euo pipefail
              declare -A REPOS=(
                [caveman]="https://github.com/JuliusBrussee/caveman main"
                [ponytail]="https://github.com/DietrichGebert/ponytail main"
              )
              for entry in "''${REPOS[@]}"; do
                read -r url branch <<< "$entry"
                tmp=$(mktemp -d)
                git clone --depth 1 -b "$branch" "$url" "$tmp"

                for skill in "$tmp"/skills/*/; do
                  [ -d "$skill" ] || continue
                  name=$(basename "$skill")
                  git -C "$tmp" subtree split --prefix="skills/$name" -b "split-$name"
                  if [ -d "skills/$name" ]; then
                    git subtree pull --prefix="skills/$name" "$tmp" "split-$name" --squash
                  else
                    git subtree add  --prefix="skills/$name" "$tmp" "split-$name" --squash
                  fi
                done

                rm -rf "$tmp"
              done
            '')
          ];
        };
      }
    );
}
