#!/usr/bin/env dash

temp_file="/tmp/tmux_startup.conf"

tmux_assets_directory="$HOME/nix/assets/tmux"
transit_to_root="source \"$tmux_assets_directory/mode_transictions/root.conf\""
transit_to_prefix="source \"$tmux_assets_directory/mode_transictions/prefix.conf\""
transit_to_persistent_prefix="source \"$tmux_assets_directory/mode_transictions/persistent_prefix.conf\""

# Create a new config file
cat >"$temp_file" <<EOF
# General Settings
set -g base-index 1
set -g pane-base-index 1
set -g status-keys vi
set -g mode-keys vi
set -g mouse off
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
bind -T root C-Space $transit_to_prefix
bind -T prefix Escape $transit_to_root
bind -T prefix Space $transit_to_persistent_prefix
bind -T persistent_prefix Escape $transit_to_root
bind -T persistent_prefix Space $transit_to_prefix

EOF

append_bindings() {
  local table="$1" persistent_table="$2"
  shift 2

  {
    while [ $# -ge 2 ]; do
      local key="$1" action="$2"
      shift 2
      echo "bind -T $table '$key' { $action; $transit_to_root }"
      echo "bind -r -T $persistent_table '$key' { $action }"
    done
  } >>"$temp_file"
}

append_bindings prefix persistent_prefix \
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

# Load the configuration with a single call
tmux source "$temp_file"
