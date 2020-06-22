{ pkgs ? import <nixpkgs> {} }:

with pkgs;
{
  inherit shellcheck
          ansible_2_8;
  inherit (python37Packages)
          ansible-lint;
  inherit (haskellPackages)
          dhall_1_27_0;
}
