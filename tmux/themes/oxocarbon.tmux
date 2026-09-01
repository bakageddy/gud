oxo_bg="#161616"
oxo_fg="#f2f4f8"
oxo_base00="#262626"
oxo_base01="#393939"
oxo_base02="#525252"
oxo_base03="#dde1e6"
oxo_pink="#ff7eb6"
oxo_purple="#be95ff"
oxo_blue="#78a9ff"
oxo_cyan="#3ddbd9"
oxo_green="#42be65"
oxo_yellow="#ffe97b"
oxo_orange="#ff832b"
oxo_red="#ee5396"

# Tmux options
set-option -g status-position top
set-option -g status-style "bg=${oxo_base00},fg=${oxo_fg}"
set-option -g status-left-length 50
set-option -g status-right-length 0
set-option -g status-right ""

# Pane borders
set-option -g pane-border-style "fg=${oxo_base01}"
set-option -g pane-active-border-style "fg=${oxo_blue}"

# Window status
set-option -g window-status-style "fg=${oxo_base02}"
set-option -g window-status-current-style "fg=${oxo_blue},bold"
set-option -g window-status-format " #I:#W "
set-option -g window-status-current-format " #I:#W "
set-option -g window-status-separator ""

# Status left - Session name and mode indicator
set-option -g status-left "#[fg=${oxo_base03},bg=${oxo_base00},bold] #S #[fg=${oxo_blue},bg=${oxo_bg}]#{?client_prefix,#[fg=${oxo_bg}]#[bg=${oxo_pink}] PREFIX #[fg=${oxo_pink}]#[bg=${oxo_bg}],#{?pane_in_mode,#[fg=${oxo_bg}]#[bg=${oxo_yellow}]  COPY  #[fg=${oxo_cyan}]#[bg=${oxo_bg}],#[fg=${oxo_bg}]#[bg=${oxo_cyan}] NORMAL #[fg=${oxo_green}]#[bg=${oxo_bg}]}}"

# Message style
set-option -g message-style "bg=${oxo_base00},fg=${oxo_fg}"
set-option -g message-command-style "bg=${oxo_base00},fg=${oxo_fg}"

# Mode style (for copy mode)
set-option -g mode-style "bg=${oxo_base01},fg=${oxo_cyan}"

# Clock mode
set-option -g clock-mode-colour "${oxo_blue}"
