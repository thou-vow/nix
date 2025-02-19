{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.mods.tmux.enable {
    programs.tmux.extraConfig = ''
      source "$XDG_CONFIG_HOME/tmux/root.conf"
    '';

    xdg.configFile = {
      "tmux/prefix.conf".text = ''
        set -g status-left "#[fg=white,bg=blue]PREFIX#[fg=blue,bg=default]"

        unbind -T root -a

        bind -T root C-Space source "$XDG_CONFIG_HOME/tmux/root.conf"
        bind -T root Space send-key C-Space
        bind -T root Escape send-key C-Space

        bind -T root q kill-pane
        bind -T root y split-window -v
        bind -T root S-y split-window -vb
        bind -T root '[' previous-window
        bind -T root h select-pane -L
        bind -T root j select-pane -D
        bind -T root k select-pane -U
        bind -T root l select-pane -R
        bind -T root ']' next-window
        bind -T root x split-window -h
        bind -T root S-x split-window -hb
        bind -T root Left resize-pane -L 1
        bind -T root Down resize-pane -D 1
        bind -T root Up resize-pane -U 1
        bind -T root Right resize-pane -R 1
      '';
      "tmux/root.conf".text = ''
        set -g status-left "#[fg=white,bg=red] ROOT#[fg=red,bg=default]"

        unbind -T root -a

        bind -T root C-Space source "$XDG_CONFIG_HOME/tmux/prefix.conf"
      '';
    };
  };
}
