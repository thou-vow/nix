#!/usr/bin/env dash

tmp_file="/tmp/tmux_startup.conf"

set_menu() {
  local menu_title="$1"
  shift
  menu="menu -x R -y P -T '#[align=centre,bold fg=green]$menu_title'"

  while [ $# -gt 0 ]; do
    menu="$menu \
  \"$1\" \"$2\" \"$3\" "
    shift 3
  done

  menu="${menu% \\}"
  echo "$menu"
}

prefix_mode=$(
  set_menu "Prefix" \
    "Quit pane" "q" "confirm -p 'Kill pane #P? (y/n)' killp" \
    "Vertical right split" "y" "split-window -h" \
    "Vertical left split" "Y" "split-window -hb" \
    "Goto previous window" "[" "previous-window" \
    "Swap previous window" "{" "swap-window -t '{previous}'; previous-window" \
    "Goto left pane" "h" "select-pane -L" \
    "Swap left pane" "H" "swap-pane -t '{left-of}'" \
    "Goto down pane" "j" "select-pane -D" \
    "Swap down pane" "J" "swap-pane -t '{down-of}'" \
    "Goto up pane" "k" "select-pane -U" \
    "Swap up pane" "K" "swap-pane -t '{up-of}'" \
    "Goto right pane" "l" "select-pane -R" \
    "Swap right pane" "L" "swap-pane -t '{right-of}'" \
    "Goto next window" "]" "next-window" \
    "Swap next window" "}" "swap-window -t '{next}'; next-window" \
    "Horizontal down split" "x" "split-window -v" \
    "Horizontal up split" "X" "split-window -vb" \
    "New window" "n" "new-window" \
    "Command prompt" ":" "command-prompt" \
    "Resize pane left" "Left" "resize-pane -L 1" \
    "Resize pane down" "Down" "resize-pane -D 1" \
    "Resize pane up" "Up" "resize-pane -U 1" \
    "Resize pane right" "Right" "resize-pane -R 1" \
    "Reload config" "Enter" "run '$(realpath "$0")'"
)

# Create a new config file
cat >"$tmp_file" <<EOF
# General Settings
set -g default-terminal "tmux-256color"
set -g base-index 1
set -g pane-base-index 1
set -g status-keys vi
set -g mode-keys vi
set -g mouse on
set -g focus-events off
set -g aggressive-resize off
set -g clock-mode-style 24
set -g escape-time 0
set -g history-limit 50000
set -g allow-passthrough on
set -g alternate-screen on
set -g renumber-windows on
set -g set-clipboard on
set -g display-time 500
set -g terminal-overrides ",xterm-256color:Tc"
set -g menu-selected-style ""
set -g message-style ""
set -g window-status-format "#[fg=white,dim]#I ➢ #W "
set -g window-status-current-format "#[fg=yellow,bold,nodim]#I ➢ #W#[nobold]"
set -g status off

# Unbind defaults
unbind -T root -a
unbind -T prefix -a
unbind -T copy-mode-vi -a

# Hooks
set-hook -g window-unlinked "display-message '#{W:#{E:window-status-format} ,#{E:window-status-current-format} }'"

# Mode switch
bind -T root C-Space { $prefix_mode }
EOF

# Load the configuration in a single call
tmux source "$tmp_file"

