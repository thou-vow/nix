#!/usr/bin/env dash

temp_file="/tmp/tmux_startup.conf"

transit_to_root="set -g key-table root; set -g status-left \"#[fg=white,bg=red,bold] ROOT #[fg=red,bg=default,nobold]\""
transit_to_prefix="set -g key-table prefix; set -g status-left \"#[fg=white,bg=blue,bold]PREFIX#[fg=blue,bg=default,nobold]\""
transit_to_persistent_prefix="set -g key-table persistent-prefix; set -g status-left \"#[fg=white,bg=blue,bold,italics]PREFIX#[fg=blue,bg=default,nobold,noitalics]\""
transit_to_persistent_copy="copy-mode; set -g key-table persistent-copy; set -g status-left \"#[fg=white,bg=orange,bold,italics] COPY #[fg=orange,bg=default,nobold,noitalics]\""

# Create a new config file
cat >"$temp_file" <<EOF
# General Settings
set -g base-index 1
set -g pane-base-index 1
set -g status-keys vi
set -g mode-keys vi
set -g mouse on
set -g focus-events off
set -g aggressive-resize off
set -g clock-mode-style 24
set -g escape-time 0
set -g history-limit 5000
set -g allow-passthrough on
set -g alternate-screen on
set -g renumber-windows on
set -g set-clipboard on
set -g default-terminal "tmux-256color"

# Status Bar
set -g status-position top
set -g status-justify centre
set -g status-style "bg=#191724"
set -g status-left-length 10
set -g status-right "#[fg=white,bg=default,nobold]  #[fg=magenta,bg=default,bold]#S "
set -g window-status-style "fg=white dim"
set -g window-status-format " #I ➢ #W "
set -g window-status-current-style "fg=yellow bold"
set -g window-status-current-format " #I ➢ #W "

$transit_to_root

# Unbind keys
set -g prefix None
unbind -T root -a
unbind -T prefix -a

# Switch mode bindings
bind -T root C-Space { $transit_to_prefix }
bind -T root C-b { $transit_to_persistent_copy }
bind -T prefix Escape { $transit_to_root }
bind -T prefix Space { $transit_to_persistent_prefix }
bind -T persistent-prefix Escape { $transit_to_root }
bind -T persistent-prefix Space { $transit_to_prefix }
bind -T persistent-copy Escape { $transit_to_root }
EOF

append_bindings() {
  local table="$1"
  shift
  {
    while [ $# -ge 2 ]; do
      local key="$1" action="$2"
      shift 2
      echo "bind -T $table '$key' { $action; $transit_to_root }"
    done
  } >>"$temp_file"
}

append_bindings_persistent() {
  local table="$1"
  shift
  {
    while [ $# -ge 2 ]; do
      local key="$1" action="$2"
      shift 2
      echo "bind -r -T $table '$key' { $action }"
    done
  } >>"$temp_file"
}

append_bindings prefix \
  "q" "kill-pane" \
  "y" "split-window -h" \
  "Y" "split-window -hb" \
  "[" "previous-window" \
  "{" "swap-window -t '{previous}'; previous-window" \
  "h" "select-pane -L" \
  "H" "swap-pane -t '{left-of}'" \
  "j" "select-pane -D" \
  "J" "swap-pane -t '{down-of}'" \
  "k" "select-pane -U" \
  "K" "swap-pane -t '{up-of}'" \
  "l" "select-pane -R" \
  "L" "swap-pane -t '{right-of}'" \
  "]" "next-window" \
  "}" "swap-window -t '{next}'; next-window" \
  "x" "split-window -v" \
  "X" "split-window -vb" \
  "n" "new-window" \
  "Left" "resize-pane -L 1" \
  "Down" "resize-pane -D 1" \
  "Up" "resize-pane -U 1" \
  "Right" "resize-pane -R 1"

append_bindings_persistent persistent-prefix \
  "q" "kill-pane" \
  "y" "split-window -h" \
  "Y" "split-window -hb" \
  "[" "previous-window" \
  "{" "swap-window -t '{previous}'" \
  "h" "select-pane -L" \
  "H" "swap-pane -t '{left-of}'" \
  "j" "select-pane -D" \
  "J" "swap-pane -t '{down-of}'" \
  "k" "select-pane -U" \
  "K" "swap-pane -t '{up-of}'" \
  "l" "select-pane -R" \
  "L" "swap-pane -t '{right-of}'" \
  "]" "next-window" \
  "}" "swap-window -t '{next}'" \
  "x" "split-window -v" \
  "X" "split-window -vb" \
  "n" "new-window" \
  "Left" "resize-pane -L 1" \
  "Down" "resize-pane -D 1" \
  "Up" "resize-pane -U 1" \
  "Right" "resize-pane -R 1"

append_bindings_persistent persistent-copy \
  "y" "send-keys -X copy-selection-and-cancel" \
  "j" "send-keys -X cursor-down" \
  "k" "send-keys -X cursor-up" \
  "v" "send-keys -X begin-selection" \
# Load the configuration with a single call
tmux source "$temp_file"
