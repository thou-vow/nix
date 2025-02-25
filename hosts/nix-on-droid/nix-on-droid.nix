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
      man
      nano
      openssh
      procps
      psmisc
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
    colors = {
      background = "#191724";
      foreground = "#e0def4";
      cursor = "#825b65";
      color0 = "#817c9c";
      color1 = "#eb6f92";
      color2 = "#9ccfd8";
      color3 = "#f6c177";
      color4 = "#3e8fb0";
      color5 = "#c4a7e7";
      color6 = "#ea9a97";
      color7 = "#e0def4";
      color8 = "#6e6a86";
      color9 = "#eb6f92";
      color10 = "#9ccfd8";
      color11 = "#f6c177";
      color12 = "#31748f";
      color13 = "#c4a7e7";
      color14 = "#ebbcba";
      color15 = "#e0def4";
    };
  };

  time.timeZone = "America/Sao_Paulo";

  user.shell = "${lib.getExe pkgs.fish}";
}
