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
      nixd
      nixfmt-rfc-style
      unimatrix # Simulate display from unimatrix

      ## Rust
      cargo
      clippy
      rust-analyzer
      rustc
      rustfmt
      rustycli # Playground
    ];
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      SHELL = "fish";
      SUDO_EDITOR = "hx";
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
