{ pkgs, ... }:

{
  imports = [
    ./secrets.nix
    ../../mods/mods.nix
  ];

  mods = {
    fish.enable = true;
    gh.enable = true;
    gitui.enable = true;
    helix.enable = true;
    langs = {
      c.enable = true;
      dash.enable = true;
      typst.enable = true;
      java.enable = true;
      rust.enable = true;
    };
    tmux.enable = true;
    yazi.enable = true;
  };

  home = {
    packages = with pkgs; [
      fastfetch # Show system/device info
      gcc # C compiler
      hostname # Show hostname
      libqalculate # Calculator
      unimatrix # Simulate display from matrix
    ];
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      SHELL = "fish";
    };
    shellAliases = {
      "w.home-manager" = "w3m https://nix-community.github.io/home-manager/options.xhtml";
      "w.nix.dev" = "w3m https://nix.dev/manual/nix/latest/";
      "w.nixos" = "w3m https://nixos.org/manual/nixos/unstable/";
      "w.nixpkgs" = "w3m https://nixos.org/manual/nixpkgs/unstable/";
      "w.nix-on-droid" = "w3m https://nix-community.github.io/nix-on-droid/nix-on-droid-options.html";
    };
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

}
