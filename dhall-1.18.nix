{ pkgs ? import <nixpkgs> {} }: with pkgs;

stdenv.mkDerivation rec {
  name = "dhall-${version}";
  version = "1.18.0";
  phases = [ "installPhase "];
  src = fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-${version}-x86_64-linux.tar.bz2";
    sha256 = "0jvw6ss96xifb21mzpvfjzvaffcnpj0jhpc4rd36cl2r22800qgx";
  };
  installPhase = ''
    mkdir -p $out/bin
    tar -xjf $src
    mv bin/dhall $out/bin/
  '';
}
