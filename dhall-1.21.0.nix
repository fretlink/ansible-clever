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
  mkVersion "1.21.0" "0x7q6v1y62fq6724kx1hcfp1fcqv3lbv33ji6jzfd5y316a31r77"
