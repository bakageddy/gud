# FILE: osaka.tmux.conf

set -g status-position bottom
set -g status-justify centre
set -g status-style "bg=#001419"
set -g window-style ""
set -g window-active-style ""

# modules
module_left_1="#h"
# module_left_2="#{client_width}x#{client_height}"

module_right_1="%a %d %b"
module_right_2="%R %Z"

set -g status-left " #[fg=#db302d]$module_left_1"
set -g status-left-style ""
set -g status-left-length 50

set -g status-right "$module_right_1 #[fg=#839395]$module_right_2 "
set -g status-right-style "fg=#29a298"
set -g status-right-length 25

set -g window-status-current-style "bold"
set -g window-status-style "fg=#268bd3"
set -g window-status-format " #[fg=#849900]#{?#{==:#W,fish},#{b:pane_current_path},#W}#F "
set -g window-status-current-format " #[fg=#d23681]#{?#{==:#W,fish},#{b:pane_current_path},#W}#F "
set -g window-status-separator ""

set -g pane-active-border-style "fg=#b28500"
set -g pane-border-style "fg=#839395"
