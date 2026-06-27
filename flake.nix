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
      url = "path:./tools/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jetbrainsPlugins = {
      url = "github:theCapypara/nix-jetbrains-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llmAgents = {
      url = "github:numtide/llmagents";
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
      llmAgents,
      ...
    }:
    flakeUtils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          inherit system;
          overlays = [
            (import ./nixpkgs/lan-mouse.nix)
            nixgl.overlays.default
          ];
        };
        importNix =
          dir: name:
          import (dir + "/${name}.nix") {
            inherit
              pkgs
              system
              systemManager
              jetbrainsPlugins
              llmAgents
              ;
            inherit (pkgs) nixGLWrap;
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
            shfmt
          ];
        };
      }
    );
}
