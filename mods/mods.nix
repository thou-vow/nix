{ lib, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./helix/helix.nix
    ./rust.nix
    ./tmux/tmux.nix
    ./typst.nix
    ./yazi/yazi.nix
  ];

  options.mods.nix.enable = lib.mkEnableOption "enable nix";
}
