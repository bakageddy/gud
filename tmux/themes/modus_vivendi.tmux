set-option -g status-position "bottom"
set-option -g status-style bg=#000000,fg=#f0f0f0
set-option -g status-left '#[bg=#44bc44,fg=#000000,bold]#{?client_prefix,,  tmux  }#[bg=#79a8ff,fg=#1e1e1e,bold]#{?client_prefix,  tmux  ,}'
set-option -g status-right '#S'
set-option -g window-status-format ' #I:#W '
set-option -g window-status-current-format '#[bg=#2fafff,fg=#000000] #I:#W#{?window_zoomed_flag,  , }'
