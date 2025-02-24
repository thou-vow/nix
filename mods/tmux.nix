{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mods.tmux.enable = lib.mkEnableOption "enable";

  config = lib.mkIf config.mods.tmux.enable {
    programs.tmux = {
      enable = true;
      package = pkgs.tmux;
      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 5000;
      keyMode = "vi";
      resizeAmount = 1;
      terminal = "tmux-256color";

      extraConfig =
        let
          tmuxAssetsDirectory = "${config.home.homeDirectory}/nix/assets/tmux";
          rootTransiction = "${tmuxAssetsDirectory}/modeTransictions/root.conf";
          prefixTransiction = "${tmuxAssetsDirectory}/modeTransictions/prefix.conf";
          persistentPrefixTransiction = "${tmuxAssetsDirectory}/modeTransictions/persistent-prefix.conf";
        in
        ''
          set -g allow-passthrough on
          set -g alternate-screen on
          set -g renumber-windows on
          set -g set-clipboard on

          set -g status-position top
          set -g status-justify centre
          set -g status-style 'bg=#191724'
          source "${rootTransiction}"
          set -g status-left-length 10
          set -g status-right '#[fg=white,bg=default]#S '
          set -g status-right-length 10

          set -g window-status-style 'fg=white dim'
          set -g window-status-format ' #I '
          set -g window-status-current-style 'fg=yellow bold'
          set -g window-status-current-format ' #I '

          set -g prefix None
          unbind -T root -a
          bind -T root C-Space source "${prefixTransiction}"

          unbind -T prefix -a
          bind -T prefix Escape source "${rootTransiction}"
          bind -T prefix Space source "${persistentPrefixTransiction}"
          bind -T prefix q { kill-pane ; source "${rootTransiction}" }
          bind -T prefix y { split-window -h ; source "${rootTransiction}" }
          bind -T prefix Y { split-window -hb ; source "${rootTransiction}" }
          bind -T prefix '[' { previous-window ; source "${rootTransiction}" }
          bind -T prefix h { select-pane -L ; source "${rootTransiction}" }
          bind -T prefix j { select-pane -D ; source "${rootTransiction}" }
          bind -T prefix k { select-pane -U ; source "${rootTransiction}" }
          bind -T prefix l { select-pane -R ; source "${rootTransiction}" }
          bind -T prefix ']' { next-window ; source "${rootTransiction}" }
          bind -T prefix x { split-window -v ; source "${rootTransiction}" }
          bind -T prefix X { split-window -vb ; source "${rootTransiction}" }
          bind -T prefix n { new-window ; source "${rootTransiction}" }
          bind -T prefix Left { resize-pane -L 1 ; source "${rootTransiction}" }
          bind -T prefix Down { resize-pane -D 1 ; source "${rootTransiction}" }
          bind -T prefix Up { resize-pane -U 1 ; source "${rootTransiction}" }
          bind -T prefix Right { resize-pane -R 1 ; source "${rootTransiction}" }

          bind -T persistent-prefix Escape source "${rootTransiction}"
          bind -T persistent-prefix Space source "${prefixTransiction}"
          bind -r -T persistent-prefix q kill-pane
          bind -r -T persistent-prefix y split-window -h
          bind -r -T persistent-prefix Y split-window -hb
          bind -r -T persistent-prefix '[' previous-window
          bind -r -T persistent-prefix h select-pane -L
          bind -r -T persistent-prefix j select-pane -D
          bind -r -T persistent-prefix k select-pane -U
          bind -r -T persistent-prefix l select-pane -R
          bind -r -T persistent-prefix ']' next-window
          bind -r -T persistent-prefix x split-window -v
          bind -r -T persistent-prefix X split-window -vb
          bind -r -T persistent-prefix n new-window
          bind -r -T persistent-prefix Left resize-pane -L 1
          bind -r -T persistent-prefix Down resize-pane -D 1
          bind -r -T persistent-prefix Up resize-pane -U 1
          bind -r -T persistent-prefix Right resize-pane -R 1

          source "${tmuxAssetsDirectory}/startup.conf"
        '';
    };
  };
}
