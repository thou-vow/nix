{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./modes.nix
  ];

  options.mods.tmux.enable = lib.mkEnableOption "enable";

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
        set -g allow-passthrough on
        set -g focus-events off
        set -g set-clipboard on

        set -g status-position top
        set -g status-justify centre
        set -g status-style 'bg=#191724'
        set -g status-left-length 7
        set -g status-right "#[fg=white,bg=default]#S "
        set -g status-right-length 10

        set -g window-status-style 'fg=white dim'
        set -g window-status-format ' #I '
        set -g window-status-current-style 'fg=yellow bold'
        set -g window-status-current-format ' #I '
      '';
    };
  };
}
