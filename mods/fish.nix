{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.mods.fish.enable = lib.mkEnableOption "enable fish";

  config = lib.mkIf config.mods.fish.enable {
    home.packages = with pkgs; [
      duf # Disk usage/free utility
      perl
      pokeget-rs
      w3m # Web browser for CLI
      wiki-tui # Wikipedia
    ];

    programs = {
      # Better cat
      bat.enable = true;

      # Better ls
      eza = {
        enable = true;
        enableFishIntegration = true;
        extraOptions = [
          "--group-directories-first"
          "--icons"
        ];
      };

      # Better find
      fd.enable = true;

      # Friendly interactive shell
      fish = {
        enable = true;
        plugins = with pkgs.fishPlugins; [
          {
            # Auto add pairs
            name = "autopair";
            src = autopair.src;
          }
          {
            # Useful expansions like !! and !$
            name = "puffer";
            src = puffer.src;
          }
          {
            # Prompt
            #
            # Use this to not get error https://github.com/pure-fish/pure/issues/295#issuecomment-1673234460
            # set --universal pure_enable_container_detection false
            name = "pure";
            src = pure.src;
          }
        ];

        interactiveShellInit = ''
          # Fix visual glitches
          set -Ua fish_features no-keyboard-protocols

          # Avoid pure plugin error
          set --universal pure_enable_container_detection false

          # Set clock on prompt
          set -gx pure_show_system_time true
          set -gx pure_color_system_time green

          source "${config.home.homeDirectory}/nix/assets/fish/interactive_init.fish"
        '';

        preferAbbrs = true;
        shellAbbrs = config.home.shellAliases;
      };

      ripgrep.enable = true;

      # Better cd
      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
