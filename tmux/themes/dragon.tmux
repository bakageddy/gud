# FILE: dragon.tmux.conf

set -g status-position bottom
set -g status-justify centre
set -g status-style "bg=#181616"
set -g window-style ""
set -g window-active-style ""

# modules
module_left_1="#h"
# module_left_2="#{client_width}x#{client_height}"

module_right_1="%a %d %b"
module_right_2="%R %Z"

# set -g status-left " #[fg=#c5c9c5]$module_left_1 #[fg=#C4746E]$module_left_2"
set -g status-left " #[fg=#8EA4A2]$module_left_1"
set -g status-left-style ""
set -g status-left-length 50

set -g status-right "$module_right_1 #[fg=#C5C9C5]$module_right_2 "
set -g status-right-style "fg=#A292A3"
set -g status-right-length 25

set -g window-status-current-style "bold"
set -g window-status-style "fg=#938AA9"
set -g window-status-format " #[fg=#B98D7B]#{?#{==:#W,fish},#{b:pane_current_path},#W}#F "
set -g window-status-current-format " #[fg=#8A9A7B]#{?#{==:#W,fish},#{b:pane_current_path},#W}#F "
set -g window-status-separator ""

set -g pane-active-border-style "fg=#8EA4A2"
set -g pane-border-style "fg=#C5C9C5"
