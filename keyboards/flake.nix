{
  description = "ZMK firmware matrix — all keyboards";

  inputs.zmk-nix.url = "github:lilyinstarlight/zmk-nix";

  outputs =
    { self, zmk-nix }:
    let
      lib = zmk-nix.inputs.nixpkgs.lib;
      forAll = lib.genAttrs (builtins.attrNames zmk-nix.packages);
      boards = [ "corne+view" ];
      build =
        system: name:
        let
          zmk = zmk-nix.legacyPackages.${system};
          pkgs = zmk-nix.inputs.nixpkgs.legacyPackages.${system};
          meta = import (./. + "/${name}/keyboard.nix");
          fn = if meta.split or true then zmk.buildSplitKeyboard else zmk.buildKeyboard;
          src = pkgs.runCommand "${name}-src" { } ''
            mkdir -p $out/config
            cp -r ${./. + "/${name}"}/. $out/config/
            rm -f $out/config/keyboard.nix
          '';
        in
        fn {
          inherit name src;
          # config defaults to "config" — leave it
          inherit (meta) board shield zephyrDepsHash;
          enableZmkStudio = meta.studio or true;
        };
    in
    {
      packages = forAll (
        system:
        lib.genAttrs boards (build system)
        // {
          default = build system (builtins.head boards);
          flash = zmk-nix.packages.${system}.flash;
        }
      );

      devShells = forAll (system: {
        default = zmk-nix.devShells.${system}.default;
      });
    };
}
