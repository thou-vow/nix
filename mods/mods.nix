{ lib, ... }:

{
  imports = [
    ./fish.nix
    ./helix/helix.nix
    ./java.nix
    ./rust.nix
    ./tmux.nix
    ./typst.nix
    ./yazi/yazi.nix
  ];

  options.mods.nix.enable = lib.mkEnableOption "enable nix";
}
