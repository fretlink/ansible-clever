{ pkgs ? import <nixpkgs> {} }:

with pkgs;
{
  inherit shellcheck
          ansible_2_8
          dhall;
  inherit (python3Packages)
          ansible-lint;
}
