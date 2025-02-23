{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.mods.tmux.enable {
    programs.tmux.extraConfig = ''
      source "~/.config/tmux/root.conf"
    '';

    xdg.configFile = {
      "tmux/prefix.conf".text = ''
        set -g status-left "#[fg=white,bg=blue]PREFIX#[fg=blue,bg=default]"

        unbind -T root -a

        bind -T root Escape source "~/.config/tmux/root.conf"
        bind -T root Enter source "~/.config/tmux/root.conf"

        bind -T root q { kill-pane ; source "~/.config/tmux/root.conf" }
        bind -T root y { split-window -h ; source "~/.config/tmux/root.conf" }
        bind -T root Y { split-window -hb ; source "~/.config/tmux/root.conf" }
        bind -r -T root '[' { previous-window ; source "~/.config/tmux/root.conf" }
        bind -r -T root h { select-pane -L ; source "~/.config/tmux/root.conf" }
        bind -r -T root j { select-pane -D ; source "~/.config/tmux/root.conf" }
        bind -r -T root k { select-pane -U ; source "~/.config/tmux/root.conf" }
        bind -r -T root l { select-pane -R ; source "~/.config/tmux/root.conf" }
        bind -r -T root ']' { next-window ; source "~/.config/tmux/root.conf" }
        bind -T root x { split-window -v ; source "~/.config/tmux/root.conf" }
        bind -T root X { split-window -vb ; source "~/.config/tmux/root.conf" }
        bind -T root n { new-window ; source "~/.config/tmux/root.conf" }
        bind -r -T root Left resize-pane -L 1
        bind -r -T root Down resize-pane -D 1
        bind -r -T root Up resize-pane -U 1
        bind -r -T root Right resize-pane -R 1
      '';
      "tmux/root.conf".text = ''
        set -g status-left "#[fg=white,bg=red] ROOT #[fg=red,bg=default]"

        unbind -T root -a

        bind -T root C-Space source "~/.config/tmux/prefix.conf"
      '';
    };
  };
}
