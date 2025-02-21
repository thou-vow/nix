{ lib, pkgs, ... }:

{
  imports = [
    ./fish/fish.nix
    ./helix/helix.nix
    ./rust/rust.nix
    ./tmux/tmux.nix
    ./yazi/yazi.nix
  ];

  options.mods.nix.enable = lib.mkEnableOption "enable nix";
}
