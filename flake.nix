{
  outputs = { nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem(system:
  let
    pkgs = import nixpkgs { inherit system; };

    mkCobc = file: pkgs.stdenv.mkDerivation {
      pname = file;
      version = "head";
      src = ./src;

      buildInputs = [ pkgs.gnucobol.bin ];

      dontUnpack = true;
      dontPatch = true;
      dontConfigure = true;
      dontInstall = true;

      buildPhase = ''
        mkdir -p $out/bin
        cobc -W -x $src/${file}.cbl -o $out/bin/${file}
      '';
    };
  in {
    packages = pkgs.lib.attrsets.genAttrs (builtins.map (day: "day${toString day}") (pkgs.lib.lists.range 1 25)) mkCobc;

    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        gnucobol.bin
        gdb

        # for new_day
        xmlstarlet
      ];
    };
  });
}
