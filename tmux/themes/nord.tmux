# FILE: nord.tmux.conf

set -g status-position top
set -g status-justify centre
set -g status-style "bg=#2E3440"
set -g window-style ""
set -g window-active-style ""

# modules
module_left_1="#h"
# module_left_2="#{client_width}x#{client_height}"

module_right_1="%a %d %b"
module_right_2="%R %Z"

set -g status-left " #[fg=#D8DEE9]$module_left_1"
set -g status-left-style ""
set -g status-left-length 50

set -g status-right "$module_right_1 #[fg=#A3BE8C]$module_right_2 "
set -g status-right-style "fg=#A3BE8C"
set -g status-right-length 25

set -g window-status-current-style "bold"
set -g window-status-style "fg=#D8DEE9"
set -g window-status-format " #[fg=#D8DEE9]#{?#{==:#W,fish},#{b:pane_current_path},#W}#F "
set -g window-status-current-format " #[fg=#88C0D0]#{?#{==:#W,fish},#{b:pane_current_path},#W}#F "
set -g window-status-separator ""

set -g pane-active-border-style "fg=#ECEFF4"
set -g pane-border-style "fg=#2E3440"
