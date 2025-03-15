{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
    termux-wake-lock.enable = true;
    unsupported.enable = true;
  };

  environment = {
    etcBackupExtension = "nix-bak";
    packages = with pkgs; [
      coreutils
      diffutils
      findutils
      inetutils
      gawk
      git
      gnugrep
      gnused
      gnutar
      gzip
      hostname
      kbd
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
    ];
    motd = null;
  };

  home-manager = {
    backupFileExtension = "hm-nix-bak";
    config = ./home.nix;
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nix = {
    extraOptions = ''experimental-features = nix-command flakes pipe-operators '';
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    package = pkgs.nixVersions.latest;
  };

  # stylix = {
  #   enable = true;
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  #   # Some image
  #   image = ../../../storage/downloads/b65e01cf631c5a71dec76941b071e6ac.jpg;
  # };

  system.stateVersion = "24.05";

  terminal = {
    font =
      let
        package = pkgs.nerd-fonts.victor-mono;
        path = "share/fonts/truetype/NerdFonts/VictorMono/VictorMonoNerdFont-Regular.ttf";
      in
      "${package}/${path}";
  };

  time.timeZone = "America/Sao_Paulo";

  user.shell = "${lib.getExe pkgs.fish}";
}
