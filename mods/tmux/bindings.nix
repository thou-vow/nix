{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.mods.tmux.enable {
    programs.tmux = {
      extraConfig = ''
        unbind -n C-b
        bind -n C-Space {
          set status-left '#[fg=white,bg=blue]#S#[fg=blue,bg=default]'
          set key-table prefix
        }

        unbind -a
        bind -r '+' resize-pane -LDUR 1
        bind 'q' kill-pane
        bind 'y' split-window -v
        bind 'S-y' split-window -vb
        bind -r '[' previous-window
        bind -r 'h' select-pane -L
        bind -r 'j' select-pane -D
        bind -r 'k' select-pane -U
        bind -r 'l' select-pane -R
        bind -r ']' next-window
        bind 'x' split-window -h
        bind 'S-x' split-window -hb
        bind -r 'Left' resize-pane -L 1
        bind -r 'Down' resize-pane -D 1
        bind -r 'Up' resize-pane -U 1
        bind -r 'Right' resize-pane -R 1
        bind C-Space {
          set status-left '#[fg=white,bg=red]#S#[fg=red,bg=default]'
          set key-table root
        }
        bind Space send-keys C-Space
        bind Escape send-keys C-Space
      '';
      shortcut = "Space";
    };
  };
}
