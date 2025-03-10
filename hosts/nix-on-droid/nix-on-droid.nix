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
    extraOptions = ''
      experimental-features = nix-command flakes pipe-operators
    '';
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    package = pkgs.nixVersions.latest;
  };

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
