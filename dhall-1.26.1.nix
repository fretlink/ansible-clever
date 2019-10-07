{ pkgs ? import <nixpkgs> {} }: with pkgs;

let
  mkVersion =
    version: sha256:
      stdenv.mkDerivation {
        name = "dhall-${version}";
        inherit version;
        src = fetchurl {
          url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-${version}-x86_64-linux.tar.bz2";
          inherit sha256;
        };
        unpackPhase = ''
          tar -xjf $src
        '';
        installPhase = ''
          mkdir -p $out/bin
          mv bin/dhall $out/bin/
        '';
      };
in
  mkVersion "1.26.1" "0sl4r3mfairgd6kn26hs1r1lkh8rn992grd73078rhqf5w90ag05"
