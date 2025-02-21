{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./../../mods/mods.nix ];

  mods = {
    fish.enable = true;
    helix.enable = true;
    nix.enable = true;
    rust.enable = true;
    tmux.enable = true;
    yazi.enable = true;
  };

  home = {
    packages = with pkgs; [
      fastfetch # Show system/device info
      gcc # C compiler
      hostname # Show hostname
      jdk
      libqalculate # Calculator
      unimatrix # Simulate display from matrix
    ];
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      SHELL = "fish";
    };
    stateVersion = "24.05";
  };

  programs = {
    git = {
      userName = "thou-vow";
      userEmail = "thou.vow.etoile@gmail.com";
    };
    home-manager.enable = true;
  };
}
