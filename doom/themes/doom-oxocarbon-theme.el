;;; doom-oxocarbon-theme.el --- IBM Oxocarbon for Doom Emacs -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: 0xS3RA
;; Source: https://github.com/0xS3RA/oxocarbon"
;;
;;; Commentary:
;;
;; A high-contrast, accessibility-conscious Doom Emacs port of Oxocarbon.
;; The syntax colors follow the original Emacs port.  UI faces use the same
;; palette, with a small number of derived neutral shades where the original
;; base03 is not sufficiently legible for functional text.
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-oxocarbon-theme nil
  "Options for the `doom-oxocarbon' theme."
  :group 'doom-themes)

(defcustom doom-oxocarbon-padded-modeline doom-themes-padded-modeline
  "If non-nil, add padding to the mode line.
An integer specifies the exact padding; t uses 4 pixels."
  :group 'doom-oxocarbon-theme
  :type '(choice integer boolean))

(defcustom doom-oxocarbon-brighter-comments t
  "If non-nil, use a WCAG-readable neutral for comments.
When nil, use Oxocarbon base03 exactly, which is intentionally subdued."
  :group 'doom-oxocarbon-theme
  :type 'boolean)


;;
;;; Theme definition

(def-doom-theme doom-oxocarbon
  "A polished dark theme based on IBM Oxocarbon."
  :family 'doom-oxocarbon
  :background-mode 'dark

  ;; name          default    256        16
  ((bg           '("#161616" "#161616" "black"))
   (fg           '("#f2f4f8" "#f2f4f8" "brightwhite"))
   (bg-alt       '("#262626" "#262626" "brightblack"))
   (fg-alt       '("#dde1e6" "#dde1e6" "white"))

   ;; Oxocarbon neutral ramp. base4 is a derived midpoint: the source jumps
   ;; directly from #525252 to #dde1e6, which is too wide for layered UI text.
   (base0        '("#0f0f0f" "#080808" "black"))
   (base1        '("#161616" "#161616" "black"))
   (base2        '("#262626" "#262626" "brightblack"))
   (base3        '("#393939" "#3a3a3a" "brightblack"))
   (base4        '("#6f6f6f" "#6c6c6c" "brightblack"))
   (base5        '("#a8adb2" "#a8a8a8" "white"))
   (base6        '("#dde1e6" "#dadada" "white"))
   (base7        '("#f2f4f8" "#eeeeee" "brightwhite"))
   (base8        '("#ffffff" "#ffffff" "brightwhite"))

   ;; Original Oxocarbon chromatic ramp.
   (teal         '("#08bdba" "#00b7b3" "cyan"))
   (cyan         '("#3ddbd9" "#3bd7d5" "brightcyan"))
   (blue         '("#78a9ff" "#77aaff" "brightblue"))
   (magenta      '("#ee5396" "#ee5599" "brightmagenta"))
   (azure        '("#33b1ff" "#33afff" "blue"))
   (pink         '("#ff7eb6" "#ff7fb7" "brightmagenta"))
   (green        '("#42be65" "#42bd66" "green"))
   (violet       '("#be95ff" "#bd95ff" "magenta"))
   (light-blue   '("#82cfff" "#83cfff" "brightcyan"))

   ;; Conventional aliases required by Doom and terminal integrations.
   (grey         base4)
   (white        base8)
   (red          magenta)
   (orange       pink)
   (yellow       cyan)
   (dark-blue    azure)
   (dark-cyan    teal)

   ;; Universal syntax classes. These preserve the supplied Emacs port.
   (highlight      cyan)
   (vertical-bar   base3)
   (selection      base3)
   (builtin        pink)
   (comments       (if doom-oxocarbon-brighter-comments base4 "#525252"))
   (doc-comments   violet)
   (constants      violet)
   (functions      cyan)
   (keywords       blue)
   (methods        teal)
   (operators      blue)
   (type           blue)
   (strings        violet)
   (variables      base6)
   (numbers        light-blue)
   (region         base3)
   (error          magenta)
   (warning        pink)
   (success        green)
   (vc-modified    blue)
   (vc-added       green)
   (vc-deleted     magenta)

   ;; UI roles. Active elements use explicit foreground/background pairs.
   (cursor-color         base8)
   (active-bg            base3)
   (active-fg            base8)
   (subtle-bg            base2)
   (modeline-bg          bg)
   (modeline-bg-inactive bg)
   (modeline-fg          fg)
   (modeline-fg-inactive base5)

   (-modeline-pad
    (when doom-oxocarbon-padded-modeline
      (if (integerp doom-oxocarbon-padded-modeline)
          doom-oxocarbon-padded-modeline
        4))))

  ;;;; Core Emacs
  (((default &override) :background bg :foreground fg)
   (cursor :background cursor-color :foreground bg)
   (fringe :background bg :foreground base4)
   ;; Doom enables `window-divider-mode' globally.  Keeping all divider pixels
   ;; at the buffer background preserves window boundaries without bright rules.
   (vertical-border :foreground bg :background bg)
   (window-divider :foreground bg :background bg)
   (window-divider-first-pixel :foreground bg :background bg)
   (window-divider-last-pixel :foreground bg :background bg)
   (minibuffer-prompt :foreground cyan :weight 'bold)
   (link :foreground light-blue :underline t)
   (link-visited :foreground violet :underline t)
   ((button &override) :foreground light-blue :underline t)
   ((highlight &override) :background active-bg :foreground active-fg)
   (region :background region :foreground fg :extend t)
   (secondary-selection :background base2 :foreground fg :extend t)
   (lazy-highlight :background blue :foreground bg :weight 'bold)
   (match :background cyan :foreground bg :weight 'bold)
   (isearch :background cyan :foreground bg :weight 'bold)
   (isearch-fail :background magenta :foreground bg :weight 'bold)
   (query-replace :inherit 'isearch)
   (trailing-whitespace :background magenta)
   (escape-glyph :foreground pink)
   (homoglyph :foreground pink)
   (nobreak-space :foreground magenta :underline t)
   (shadow :foreground base5)
   (success :foreground success :weight 'bold)
   (warning :foreground warning :weight 'bold)
   (error :foreground error :weight 'bold)
   (tooltip :background base3 :foreground fg)
   (child-frame-border :background base2)
   (internal-border :background bg)
   (line-number :background bg :foreground base4)
   ;; The package defaults to inheriting `default', which makes these tildes
   ;; white.  They are gutter metadata and should match ordinary line numbers.
   (vi-tilde-fringe-face :inherit 'fringe :background bg :foreground base4)
   (line-number-current-line :background bg :foreground base6 :weight 'bold)
   (hl-line :background base2 :extend t)
   (fill-column-indicator :foreground base3)
   (whitespace-space :foreground base3)
   (whitespace-tab :foreground base3)
   (whitespace-newline :foreground base3)
   (show-paren-match :background cyan :foreground bg :weight 'bold)
   (show-paren-mismatch :background magenta :foreground bg :weight 'bold)

   ;;;; Syntax refinements
   ((font-lock-comment-face &override) :foreground comments :slant 'italic)
   ((font-lock-doc-face &override) :foreground doc-comments :slant 'italic)
   (font-lock-preprocessor-face :foreground blue)
   (font-lock-negation-char-face :foreground pink :weight 'bold)
   (font-lock-regexp-grouping-backslash :foreground pink :weight 'bold)
   (font-lock-regexp-grouping-construct :foreground cyan :weight 'bold)

   ;;;; Mode line / header line
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-inactive
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-buffer-id :foreground cyan :weight 'bold)
   (mode-line-emphasis :foreground fg :weight 'bold)
   (header-line :background base2 :foreground fg :box nil)
   (header-line-highlight :background base3 :foreground cyan)

   ;;;; Doom modeline
   ;; `doom-modeline' is the common ancestor of its text, state and icon faces.
   ;; Pinning its background to `bg' removes rectangular patches behind glyphs
   ;; while retaining color solely in their foregrounds.
   (doom-modeline :background bg :foreground fg)
   (doom-modeline-emphasis :background bg)
   (doom-modeline-highlight :background bg)
   (doom-modeline-bar :background cyan)
   (doom-modeline-bar-inactive :background base3)
   (doom-modeline-buffer-file :background bg :foreground fg :weight 'bold)
   (doom-modeline-buffer-path :background bg :foreground base6)
   (doom-modeline-buffer-project-root :background bg :foreground cyan :weight 'bold)
   (doom-modeline-buffer-modified :background bg :foreground pink :weight 'bold)
   (doom-modeline-buffer-major-mode :background bg :foreground light-blue :weight 'bold)
   (doom-modeline-buffer-minor-mode :background bg :foreground base5)
   (doom-modeline-project-dir :background bg :foreground light-blue :weight 'bold)
   (doom-modeline-project-parent-dir :background bg :foreground base5)
   (doom-modeline-info :foreground cyan)
   (doom-modeline-warning :foreground warning)
   (doom-modeline-urgent :foreground error :weight 'bold)
   (doom-modeline-debug :foreground violet)
   (doom-modeline-evil-normal-state :background bg :foreground blue :weight 'bold)
   (doom-modeline-evil-insert-state :background bg :foreground cyan :weight 'bold)
   (doom-modeline-evil-motion-state :background bg :foreground base6 :weight 'bold)
   (doom-modeline-evil-operator-state :background bg :foreground light-blue :weight 'bold)
   (doom-modeline-evil-visual-state :background bg :foreground pink :weight 'bold)
   (doom-modeline-evil-replace-state :background bg :foreground magenta :weight 'bold)
   (doom-modeline-evil-emacs-state :background bg :foreground violet :weight 'bold)

   ;;;; Evil / operation hints
   (evil-ex-substitute-matches :background magenta :foreground bg)
   (evil-ex-substitute-replacement :background green :foreground bg)
   (evil-goggles-default-face :background base3 :foreground fg)
   (evil-goggles-delete-face :background magenta :foreground bg)
   (evil-goggles-paste-face :background green :foreground bg)
   (evil-goggles-yank-face :background blue :foreground bg)

   ;;;; Company
   (company-tooltip :background base2 :foreground fg)
   (company-tooltip-selection :background base3 :foreground cyan :weight 'bold)
   (company-tooltip-common :foreground cyan :weight 'bold)
   (company-tooltip-common-selection :foreground cyan :weight 'bold)
   (company-tooltip-annotation :foreground light-blue)
   (company-tooltip-annotation-selection :foreground light-blue)
   (company-scrollbar-bg :background base2)
   (company-scrollbar-fg :background base4)
   (company-preview :background base2 :foreground base6)
   (company-preview-common :foreground cyan :weight 'bold)

   ;;;; Vertico / Orderless / minibuffer
   (vertico-current :background base3 :foreground fg :weight 'bold :extend t)
   (vertico-group-title :foreground cyan :weight 'bold)
   (vertico-group-separator :foreground base4 :strike-through t)
   (orderless-match-face-0 :foreground cyan :weight 'bold)
   (orderless-match-face-1 :foreground blue :weight 'bold)
   (orderless-match-face-2 :foreground violet :weight 'bold)
   (orderless-match-face-3 :foreground pink :weight 'bold)
   (completions-common-part :foreground cyan :weight 'bold)
   (completions-first-difference :foreground pink :weight 'bold)
   (completions-annotations :foreground base5 :slant 'italic)

   ;;;; Ivy compatibility
   (ivy-current-match :background base3 :foreground fg :weight 'bold)
   (ivy-minibuffer-match-face-1 :foreground cyan)
   (ivy-minibuffer-match-face-2 :foreground blue :weight 'bold)
   (ivy-minibuffer-match-face-3 :foreground violet :weight 'bold)
   (ivy-minibuffer-match-face-4 :foreground pink :weight 'bold)

   ;;;; Popup menus / which-key / transient
   (which-key-key-face :foreground cyan :weight 'bold)
   (which-key-command-description-face :foreground fg)
   (which-key-group-description-face :foreground blue)
   (which-key-local-map-description-face :foreground violet)
   (transient-heading :foreground cyan :weight 'bold)
   (transient-key :foreground light-blue :weight 'bold)
   (transient-argument :foreground pink :weight 'bold)
   (transient-value :foreground violet)
   (popup-face :background base2 :foreground fg)
   (popup-menu-selection-face :background base3 :foreground cyan)

   ;;;; Tabs / workspaces
   (tab-bar :background bg :foreground base5)
   (tab-bar-tab :background base3 :foreground fg :weight 'bold :box nil)
   (tab-bar-tab-inactive :background base2 :foreground base5 :box nil)
   (tab-line :background bg :foreground base5)
   (tab-line-tab-current :background base3 :foreground cyan :weight 'bold :box nil)
   (tab-line-tab-inactive :background base2 :foreground base5 :box nil)
   (centaur-tabs-default :background bg :foreground base5)
   (centaur-tabs-selected :background base2 :foreground fg :weight 'bold)
   (centaur-tabs-unselected :background bg :foreground base5)
   (centaur-tabs-active-bar-face :background cyan)
   (centaur-tabs-modified-marker-selected :foreground pink)
   (centaur-tabs-modified-marker-unselected :foreground magenta)

   ;;;; Dashboard
   (doom-dashboard-banner :foreground cyan)
   (doom-dashboard-menu-title :foreground blue :weight 'bold)
   (doom-dashboard-menu-desc :foreground fg)
   (doom-dashboard-footer :foreground violet :slant 'italic)
   (dashboard-heading :foreground cyan :weight 'bold)
   (dashboard-items-face :foreground fg)

   ;;;; Dired
   (dired-directory :foreground blue :weight 'bold)
   (dired-symlink :foreground cyan)
   (dired-header :foreground cyan :weight 'bold)
   (dired-mark :foreground pink :weight 'bold)
   (dired-marked :foreground violet :weight 'bold)
   (dired-flagged :foreground error)
   (dired-broken-symlink :background magenta :foreground bg :weight 'bold)
   (diredfl-dir-name :foreground blue :weight 'bold)
   (diredfl-file-name :foreground fg)
   (diredfl-number :foreground light-blue)

   ;;;; Treemacs / Neotree
   (doom-themes-treemacs-root-face :foreground cyan :weight 'ultra-bold :height 1.1)
   (doom-themes-treemacs-file-face :foreground fg)
   (treemacs-root-face :foreground cyan :weight 'ultra-bold :height 1.1)
   (treemacs-directory-face :foreground blue)
   (treemacs-file-face :foreground fg)
   (treemacs-git-modified-face :foreground vc-modified)
   (treemacs-git-added-face :foreground vc-added)
   (treemacs-git-renamed-face :foreground light-blue)
   (treemacs-git-conflict-face :foreground warning :weight 'bold)
   (treemacs-git-untracked-face :foreground teal)
   (treemacs-git-ignored-face :foreground base4)
   (neo-root-dir-face :foreground cyan :weight 'bold)
   (neo-dir-link-face :foreground blue)
   (neo-file-link-face :foreground fg)
   (neo-vc-edited-face :foreground vc-modified)
   (neo-vc-added-face :foreground vc-added)
   (neo-vc-removed-face :foreground vc-deleted)

   ;;;; Magit / diff / VC gutter
   (magit-section-heading :foreground cyan :weight 'bold)
   (magit-section-highlight :background base2)
   (magit-branch-local :foreground cyan)
   (magit-branch-remote :foreground green)
   (magit-hash :foreground base5)
   (magit-tag :foreground violet)
   (magit-diff-context-highlight :background base2 :foreground base6)
   (magit-diff-added :background bg :foreground green)
   (magit-diff-added-highlight :background base2 :foreground green :weight 'bold)
   (magit-diff-removed :background bg :foreground magenta)
   (magit-diff-removed-highlight :background base2 :foreground magenta :weight 'bold)
   (magit-diff-hunk-heading :background base3 :foreground fg)
   (magit-diff-hunk-heading-highlight :background blue :foreground bg :weight 'bold)
   (diff-header :background base2 :foreground base6)
   (diff-file-header :background base3 :foreground fg :weight 'bold)
   (diff-added :background bg :foreground green)
   (diff-removed :background bg :foreground magenta)
   (diff-changed :background bg :foreground blue)
   (diff-refine-added :background green :foreground bg :weight 'bold)
   (diff-refine-removed :background magenta :foreground bg :weight 'bold)
   (diff-hl-change :foreground blue :background blue)
   (diff-hl-insert :foreground green :background green)
   (diff-hl-delete :foreground magenta :background magenta)

   ;;;; Diagnostics / Flycheck / Flymake / LSP / Eglot
   (flycheck-error :underline error)
   (flycheck-warning :underline warning)
   (flycheck-info :underline cyan)
   (flycheck-fringe-error :foreground error :weight 'bold)
   (flycheck-fringe-warning :foreground warning :weight 'bold)
   (flycheck-fringe-info :foreground cyan :weight 'bold)
   (flymake-error :underline error)
   (flymake-warning :underline warning)
   (flymake-note :underline cyan)
   (lsp-face-highlight-read :background base3 :foreground fg)
   (lsp-face-highlight-write :background blue :foreground bg :weight 'bold)
   (lsp-face-highlight-textual :background base3 :foreground cyan)
   (lsp-lens-face :foreground base5 :height 0.85)
   (lsp-signature-posframe :background base2 :foreground fg)
   (lsp-signature-highlight-function-argument :foreground cyan :weight 'bold)
   (eglot-highlight-symbol-face :background base3 :foreground cyan :weight 'bold)
   (eldoc-highlight-function-argument :foreground cyan :weight 'bold)

   ;;;; Org
   (org-level-1 :foreground cyan :weight 'bold :height 1.25)
   (org-level-2 :foreground blue :weight 'bold :height 1.15)
   (org-level-3 :foreground violet :weight 'bold :height 1.1)
   (org-level-4 :foreground pink :weight 'bold)
   (org-level-5 :foreground light-blue :weight 'bold)
   (org-level-6 :foreground green :weight 'bold)
   (org-document-title :foreground cyan :weight 'bold :height 1.4)
   (org-document-info :foreground light-blue)
   (org-document-info-keyword :foreground base5)
   (org-meta-line :foreground base5 :slant 'italic)
   (org-special-keyword :foreground violet)
   (org-date :foreground light-blue :underline t)
   (org-link :foreground light-blue :underline t)
   (org-todo :background magenta :foreground bg :weight 'bold)
   (org-done :foreground green :weight 'bold)
   (org-headline-done :foreground base5)
   (org-checkbox :foreground cyan :weight 'bold)
   (org-tag :foreground pink :weight 'bold)
   ((org-block &override) :background base2 :foreground fg :extend t)
   ((org-block-background &override) :background base2 :extend t)
   ((org-block-begin-line &override) :background base2 :foreground base5 :extend t)
   ((org-block-end-line &override) :background base2 :foreground base5 :extend t)
   (org-code :foreground violet)
   (org-verbatim :foreground cyan)
   (org-quote :background base2 :foreground base6 :slant 'italic :extend t)
   (org-table :foreground light-blue)
   (org-agenda-structure :foreground cyan :weight 'bold)
   (org-agenda-date :foreground blue)
   (org-agenda-date-today :foreground cyan :weight 'bold)

   ;;;; Markdown
   (markdown-header-face :inherit 'bold)
   (markdown-header-face-1 :foreground cyan :height 1.25)
   (markdown-header-face-2 :foreground blue :height 1.15)
   (markdown-header-face-3 :foreground violet :height 1.1)
   (markdown-header-face-4 :foreground pink)
   (markdown-markup-face :foreground base5)
   (markdown-code-face :background base2 :foreground violet)
   (markdown-inline-code-face :background base2 :foreground violet)
   (markdown-link-face :foreground light-blue)
   (markdown-url-face :foreground base5 :underline t)
   (markdown-blockquote-face :foreground base6 :slant 'italic)

   ;;;; Programming modes
   (css-selector :foreground cyan)
   (css-property :foreground blue)
   (css-proprietary-property :foreground pink)
   (js2-function-param :foreground base6)
   (js2-object-property :foreground light-blue)
   (js2-jsdoc-tag :foreground pink)
   (js2-jsdoc-type :foreground blue)
   (web-mode-html-tag-face :foreground blue)
   (web-mode-html-tag-bracket-face :foreground base5)
   (web-mode-html-attr-name-face :foreground cyan)
   (web-mode-doctype-face :foreground base5)
   (web-mode-css-property-name-face :foreground blue)
   (web-mode-function-name-face :foreground cyan)
   (rust-unsafe :foreground magenta :weight 'bold)

   ;;;; Delimiters
   (rainbow-delimiters-depth-1-face :foreground cyan)
   (rainbow-delimiters-depth-2-face :foreground blue)
   (rainbow-delimiters-depth-3-face :foreground violet)
   (rainbow-delimiters-depth-4-face :foreground pink)
   (rainbow-delimiters-depth-5-face :foreground light-blue)
   (rainbow-delimiters-depth-6-face :foreground green)
   (rainbow-delimiters-depth-7-face :foreground teal)
   (rainbow-delimiters-depth-8-face :foreground base6)
   (rainbow-delimiters-depth-9-face :foreground magenta)
   (rainbow-delimiters-unmatched-face :background magenta :foreground bg :weight 'bold)

   ;;;; Terminals / ANSI
   (vterm-color-black :foreground base0 :background base0)
   (vterm-color-red :foreground magenta :background magenta)
   (vterm-color-green :foreground green :background green)
   (vterm-color-yellow :foreground pink :background pink)
   (vterm-color-blue :foreground blue :background blue)
   (vterm-color-magenta :foreground violet :background violet)
   (vterm-color-cyan :foreground cyan :background cyan)
   (vterm-color-white :foreground fg :background fg)

   ;;;; Man / help
   (help-key-binding :background base3 :foreground cyan :weight 'bold)
   (helpful-heading :foreground cyan :weight 'bold)
   (Man-overstrike :foreground cyan :weight 'bold)
   (Man-underline :foreground light-blue :underline t))

  ;;;; Variables
  ())

;;; doom-oxocarbon-theme.el ends here
