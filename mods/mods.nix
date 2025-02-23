{ lib, ... }:

{
  imports = [
    ./fish.nix
    ./helix/helix.nix
    ./rust.nix
    ./typst.nix
    ./yazi/yazi.nix
    ./zellij/zellij.nix
  ];

  options.mods.nix.enable = lib.mkEnableOption "enable nix";
}
