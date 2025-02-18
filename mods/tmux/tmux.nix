{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./bindings.nix
  ];
  
  options.mods.tmux.enable = lib.mkEnableOption "enable tmux";

  config = lib.mkIf config.mods.tmux.enable {
    programs.tmux = {
      enable = true;
      package = pkgs.tmux;

      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 500000;
      terminal = "tmux-256color";

      extraConfig = ''
        set -g status-position top
        
        set -g status-left "[#fg=white,bg=red,bold]#S#[fg=blue,bg=default]"
        set-hook -g after-prefix "[#fg=white,bg=red,bold]#S#[fg=blue,bg=default]"
        set-hook -g prefix "[#fg=white,bg=blue,bold]#S#[fg=blue,bg=default]"

        set -g window-status-format "#[fg=bg,bg=black]#[fg=default,bg=black]#I \ #W #F#[fg=black,bg=default]"
        set -g window-status-current-format "#[fg=bg,bg=cyan]#[fg=default,bg=cyan]#I \ #W #F#[fg=cyan,bg=default]"

        set -ug status-right
      '';
    };
  };
}

