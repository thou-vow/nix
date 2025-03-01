#!/usr/bin/env dash

tmuxAssetsDirectory="$HOME/nix/assets/tmux"

tmux set -g base-index      1
tmux set -g pane-base-index 1
tmux set -g status-keys vi
tmux set -g mode-keys   vi
tmux set -g mouse             off
tmux set -g focus-events      off
tmux set -g aggressive-resize off
tmux set -g clock-mode-style  24
tmux set -g escape-time       0
tmux set -g history-limit     5000
tmux set -g allow-passthrough on
tmux set -g alternate-screen on
tmux set -g renumber-windows on
tmux set -g set-clipboard on
tmux set -g default-terminal "tmux-256color"

tmux set -g status-position top
tmux set -g status-justify centre
tmux set -g status-style "bg=#191724"
tmux set -g status-left-length 10
tmux set -g status-right "#[fg=white,bg=default,nobold]  #[fg=magenta,bg=default,bold]#S "

tmux set -g window-status-style "fg=white dim"
tmux set -g window-status-format " #I ➢ #W "
tmux set -g window-status-current-style "fg=yellow bold"
tmux set -g window-status-current-format " #I ➢ #W "

rootTransiction="$tmuxAssetsDirectory/mode_transictions/root.conf"
prefixTransiction="$tmuxAssetsDirectory/mode_transictions/prefix.conf"
persistentPrefixTransiction="$tmuxAssetsDirectory/mode_transictions/persistent_prefix.conf"
moveTransiction="$tmuxAssetsDirectory/mode_transictions/move.conf"
persistentMoveTransiction="$tmuxAssetsDirectory/mode_transictions/persistent_move.conf"

tmux source "$rootTransiction"

tmux set -g prefix None
tmux unbind -T root -a
tmux bind -T root C-Space "source $prefixTransiction"
tmux bind -T root C-s "source $moveTransiction"

tmux unbind -T prefix -a
tmux bind -T prefix Escape "source $rootTransiction"
tmux bind -T prefix Space "source $persistentPrefixTransiction"
tmux bind -T prefix q "kill-pane; source $rootTransiction"
tmux bind -T prefix y "split-window -h; source $rootTransiction"
tmux bind -T prefix Y "split-window -hb; source $rootTransiction"
tmux bind -T prefix '[' "previous-window; source $rootTransiction"
tmux bind -T prefix '{' "swap-window -t '{previous}'; source $rootTransiction"
tmux bind -T prefix h "select-pane -L; source $rootTransiction"
tmux bind -T prefix H "swap-pane -t '{left-of}'; source $rootTransiction"
tmux bind -T prefix j "select-pane -D; source $rootTransiction"
tmux bind -T prefix J "swap-pane -t '{down-of}'; source $rootTransiction"
tmux bind -T prefix k "select-pane -U; source $rootTransiction"
tmux bind -T prefix K "swap-pane -t '{up-of}'; source $rootTransiction"
tmux bind -T prefix l "select-pane -R; source $rootTransiction"
tmux bind -T prefix L "swap-pane -t '{right-of}'; source $rootTransiction"
tmux bind -T prefix ']' "next-window; source $rootTransiction"
tmux bind -T prefix '}' "swap-window -t '{next}'; source $rootTransiction"
tmux bind -T prefix x "split-window -v; source $rootTransiction"
tmux bind -T prefix X "split-window -vb; source $rootTransiction"
tmux bind -T prefix n "new-window; source $rootTransiction"
tmux bind -T prefix N "new-window -b -t '{start}'; source $rootTransiction"
tmux bind -T prefix Left "resize-pane -L 1; source $rootTransiction"
tmux bind -T prefix Down "resize-pane -D 1; source $rootTransiction"
tmux bind -T prefix Up "resize-pane -U 1; source $rootTransiction"
tmux bind -T prefix Right "resize-pane -R 1; source $rootTransiction"

tmux bind -T persistent_prefix Escape "source $rootTransiction"
tmux bind -T persistent_prefix Space "source $prefixTransiction"
tmux bind -r -T persistent_prefix q "kill-pane"
tmux bind -r -T persistent_prefix y "split-window -h"
tmux bind -r -T persistent_prefix Y "split-window -hb"
tmux bind -r -T persistent_prefix '[' "previous-window"
tmux bind -r -T persistent_prefix '{' "swap-window -t '{previous}'"
tmux bind -r -T persistent_prefix h "select-pane -L"
tmux bind -r -T persistent_prefix H "swap-pane -t '{left-of}'"
tmux bind -r -T persistent_prefix j "select-pane -D"
tmux bind -r -T persistent_prefix J "swap-pane -t '{down-of}'"
tmux bind -r -T persistent_prefix k "select-pane -U"
tmux bind -r -T persistent_prefix K "swap-pane -t '{up-of}'"
tmux bind -r -T persistent_prefix l "select-pane -R"
tmux bind -r -T persistent_prefix L "swap-pane -t '{right-of}'"
tmux bind -r -T persistent_prefix ']' "next-window"
tmux bind -r -T persistent_prefix '}' "swap-window -t '{next}'"
tmux bind -r -T persistent_prefix x "split-window -v"
tmux bind -r -T persistent_prefix X "split-window -vb"
tmux bind -r -T persistent_prefix n "new-window"
tmux bind -r -T persistent_prefix Left "resize-pane -L 1"
tmux bind -r -T persistent_prefix Down "resize-pane -D 1"
tmux bind -r -T persistent_prefix Up "resize-pane -U 1"
tmux bind -r -T persistent_prefix Right "resize-pane -R 1"

tmux bind -T move Escape "source $rootTransiction"
tmux bind -T move Space "source $persistentMoveTransiction"
tmux bind -T move h "cursor-left; source $rootTransiction"
tmux bind -T move j "cursor-down; source $rootTransiction"
tmux bind -T move k "cursor-up; source $rootTransiction"
tmux bind -T move l "cursor-right; source $rootTransiction"
tmux bind -T move v "set-mark; source $rootTransiction"
tmux bind -T move Down "scroll-down; source $rootTransiction"
tmux bind -T move Up "scroll-up; source $rootTransiction"

tmux bind -T persistent_move Escape "source $rootTransiction"
tmux bind -T persistent_move Space "source $moveTransiction"
tmux bind -r -T persistent_move h "cursor-left"
tmux bind -r -T persistent_move j "cursor-down"
tmux bind -r -T persistent_move k "cursor-up"
tmux bind -r -T persistent_move l "cursor-right"
tmux bind -r -T persistent_move v "set-mark"
tmux bind -r -T persistent_move Down "scroll-down"
tmux bind -r -T persistent_move Up "scroll-up"
