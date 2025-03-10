{
  pkgs,
  ...
}:

{
  imports = [
    ./secrets.nix
    ../../mods/mods.nix
  ];

  mods = {
    dash.enable = true;
    fish.enable = true;
    helix.enable = true;
    java.enable = true;
    rust.enable = true;
    tmux.enable = true;
    typst.enable = true;
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
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
