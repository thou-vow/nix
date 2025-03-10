{
  inputs,
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
    file.".termux/font.ttf".source =
      let
        package = pkgs.nerd-fonts.victor-mono;
        path = "share/fonts/truetype/NerdFonts/VictorMono/VictorMonoNerdFont-Regular.ttf";
      in
      "${package}/${path}";
    packages = with pkgs; [
      diffutils
      findutils
      coreutils
      gawk
      git
      gnugrep
      gnused
      gnutar
      gzip
      hostname
      kbd # For showkey -a command
      man
      manix
      nano
      openssh
      oscclip
      procps
      psmisc
      sops
      unzip
      vim
      wget
      which
      zip
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

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes pipe-operators
    '';
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    package = pkgs.nixVersions.latest;
  };

  programs.home-manager.enable = true;
}
