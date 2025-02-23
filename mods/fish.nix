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
        extraOptions = [ "--icons" ];
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

        preferAbbrs = true;
        shellAbbrs = {
          ".." = "cd ..";
          "../.." = "cd ../..";
          "../../.." = "cd ../../..";
          cat = "bat";
          cd = "z";
          e = "exit";
          find = "fd";
          g = "git";
          ga = "git add";
          gaa = "git add --all";
          gc = "git clone";
          gcm = "git commit -m";
          gp = "git push";
          h = lib.mkIf config.mods.helix.enable "hx";
          helix = lib.mkIf config.mods.helix.enable "hx";
          t = lib.mkIf config.mods.tmux.enable "tmux";
          wiki = "wiki-tui";
          yy = "nix-on-droid switch --flake ~/nix#default";

          ## Docs
          "w.home-manager" = "w3m https://nix-community.github.io/home-manager/options.xhtml";
          "w.nix.dev" = "w3m https://nix.dev/manual/nix/latest/";
          "w.nixos" = "w3m https://nixos.org/manual/nixos/unstable/";
          "w.nixpkgs" = "w3m https://nixos.org/manual/nixpkgs/unstable/";
          "w.nix-on-droid" = "w3m https://nix-community.github.io/nix-on-droid/nix-on-droid-options.html";
        };

        shellInit = ''
          # Avoid pure plugin error
          set --universal pure_enable_container_detection false

          # Set clock on prompt
          set -gx pure_show_system_time true
          set -gx pure_color_system_time green

          # Summon pokémon
          pokeget random --hide-name
        '';
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
