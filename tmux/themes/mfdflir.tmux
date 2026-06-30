# FILE: gruvbox.tmux.conf

set -g status-position top
set -g status-justify centre
set -g status-style "bg=#202020"
set -g window-style ""
set -g window-active-style ""

# modules
module_left_1="#h"
# module_left_2="#{client_width}x#{client_height}"

module_right_1="%a %d %b"
module_right_2="%R %Z"

# set -g status-left " #[fg=#909090]$module_left_1 #[fg=#a8a8a8]$module_left_2"
set -g status-left " #[fg=#909090]$module_left_1"
set -g status-left-style ""
set -g status-left-length 50

set -g status-right "$module_right_1 #[fg=#404040]$module_right_2 "
set -g status-right-style "fg=#909090"
set -g status-right-length 25

set -g window-status-current-style "bold"
set -g window-status-style "fg=#909090"
set -g window-status-format " #[fg=#909090]#{?#{==:#W,fish},#{b:pane_current_path},#W}#F "
set -g window-status-current-format " #[fg=#a8a8a8]#{?#{==:#W,fish},#{b:pane_current_path},#W}#F "
set -g window-status-separator ""

set -g pane-active-border-style "fg=#c0c0c0"
set -g pane-border-style "fg=#202020"
