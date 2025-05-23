{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../mods/nixos/nixos.nix
    ./hardware-configuration.nix
    ./attuned-specialisation.nix
  ];

  mods.nixos = {
    x = {
      dwm.enable = true;
    };
  };

  boot = {
    tmp.cleanOnBoot = true;
    kernel.sysctl = {
      "vm.swappiness" = 5;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_background_bytes" = 1677216;
      "vm.dirty_bytes" = 50331648;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = [
      "ath9k_core.nohwcrypt=1"
      "mitigations=off"
      "pcie_aspm=off"
      "zswap.enabled=1"
      "zswap.accept_threshold_percent=70"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=50"
      "zswap.zpool=zsmalloc"
    ];
    loader = {
      efi.efiSysMountPoint = "/boot/efi";
      grub = {
        enable = true;
        device = "/dev/disk/by-id/wwn-0x500003988168a3bd";
        efiInstallAsRemovable = true;
        efiSupport = true;
      };
    };
  };

  console.useXkbConfig = true;

  environment = {
    systemPackages = with pkgs; [
      brightnessctl
      btop
      duf
      fhs
      git
      parted
      pciutils
      playerctl
      snake4
      sudo
      vim
      wget
      xclip
    ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  networking = {
    hostName = "u";
    nameservers = [
      "1.0.0.1"
      "1.1.1.1"
    ];
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.powersave = false;
    };
  };

  nix = {
    package = pkgs.nixVersions.git;

    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    registry = lib.mapAttrs (_: value: {flake = value;}) (lib.filterAttrs (_: value: lib.isType "flake" value) inputs);

    settings = {
      auto-optimise-store = true;
      experimental-features = ["flakes" "nix-command" "pipe-operators"];
      flake-registry = "";
      system-features = ["gccarch-skylake"];
      trusted-users = ["@wheel"];
    };
  };

  programs = {
    appimage.enable = true;
    firefox.enable = true;
    nh.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    libinput = {
      enable = true;
      touchpad = {
        clickMethod = "clickfinger";
        naturalScrolling = true;
      };
    };
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    pulseaudio.enable = false;
    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 20;
      xkb = {
        layout = "br,us";
        options = "caps:escape_shifted_capslock,grp:win_space_toggle";
      };
    };
  };

  system.stateVersion = "25.05";

  time.timeZone = "America/Sao_Paulo";

  users.users = {
    "thou" = {
      isNormalUser = true;
      description = "thou";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
