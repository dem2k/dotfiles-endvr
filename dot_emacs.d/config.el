;;; -*- no-byte-compile: t; lexical-binding: t; -*-

(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)

;; (add-to-list 'display-buffer-alist
;;              '("*helpful*" display-buffer-pop-up-frame))
;; (setq help-window-select t)

(add-to-list 'load-path "~/.emacs.d/pkgs")

(setq-default
 tab-width 4
 indent-tabs-mode nil ;; Prefer spaces over tabs.
 tab-always-indent 'complete ;; Enable indentation and completion using the TAB key?
 display-line-numbers t
 display-line-numbers-width 3
 display-line-numbers-widen t
 fill-column 80
 ;; display-line-numbers-type 'relative
 cursor-in-non-selected-windows nil
 large-file-warning-threshold (* 512 1000 1000)
 )

(setq ;; all the settings!
 confirm-kill-processes nil
 ;; column-number-mode t
 delete-selection-mode t
 ;; global-auto-revert-non-file-buffers t
 help-window-select t
 inhibit-compacting-font-caches t  ;; Font compacting can be expensive, especially for rendering icon fonts on Windows
 kill-ring-max 20
 ;; read-answer-short t
 ;; use-short-answers t
 ;; echo-keystrokes 0.25
 create-lockfiles nil
 make-backup-files nil
 ;; max-mini-window-height 2
 confirm-nonexistent-file-or-buffer nil ;; Skip confirmation prompts when creating a new file or buffer
 uniquify-buffer-name-style 'forward
 scroll-margin 15
 ;; scroll-conservatively 101
 mouse-yank-at-point t
 ;; native-comp-async-report-warnings-errors nil
 ;; package-install-upgrade-built-in t
 pixel-scroll-precision-mode t
 ;; prefer-coding-system 'utf-8-unix
 ;; resize-mini-windows t
 lazy-highlight-initial-delay 0 ;; Eliminate delay before highlighting search matches
 ;; revert-without-query t
 ;; ring-bell-function 'ignore
 save-interprogram-paste-before-kill t
 ;; sentence-end-double-space nil
 ;; set-charset-priority 'unicode
 ;; use-dialog-box nil
 visible-bell nil
 ;; warning-minimum-level :error
 ;; x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)
 vc-git-log-switches '("--all" "--graph" "--abbrev-commit" "--pretty=format:%C(auto)%h%<(3)%d %s %C(bold blue)(%cr, %an)%Creset")
 enable-recursive-minibuffers t
 isearchp-mouse-2-flag nil
 isearchp-regexp-quote-yank-flag nil
 )

;; Do not allow the cursor in the minibuffer prompt
(setq minibuffer-prompt-properties
	  '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(use-package emacs
  :init
  (setq modus-themes-paren-match '(bold intense)
        modus-themes-syntax '(alt-syntax)
        modus-themes-mode-line '(accented borderless)
        ;; modus-themes-hl-line '(accented underline intense)
        modus-themes-region '(accented)
        ;; modus-themes-region '(accented bg-only)
        modus-themes-bold-constructs t
        ;; modus-themes-headings '((1. (rainbow 1.5)) (2. (rainbow 1.4))
        ;;                         (3. (rainbow 1.3)) (4. (rainbow 1.2)) (t. (rainbow 1.1)))
        modus-themes-org-blocks 'tinted-background)
  ;; :custom-face
  ;; (modus-themes-hl-line ((t (:extend t :background "gray9"))) t)
  :config
  (load-theme 'modus-vivendi t))

(cua-mode +1)
(display-line-numbers-mode +1)
(global-hl-line-mode +1)
(savehist-mode +1)
;; (save-place-mode +1)
(global-auto-revert-mode +1)
;; (winner-mode +1)
(electric-pair-mode +1)
;; (set-fringe-mode 10)
(tab-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode +1)
(scroll-bar-mode -1)
(file-name-shadow-mode +1)

(add-to-list 'auto-mode-alist
             '("\\.java\\'" . java-ts-mode)
             ;; '("\\.js\\'" . js-ts-mode)
             ;; '("\\.js\\'" . javascript-mode)
             '("\\.yaml\\'" . yaml-ts-mode))

(add-to-list 'major-mode-remap-alist
             ;; '(js-mode . js-ts-mode)
             '(java-mode . java-ts-mode))

;; real autosave all buffer after timeout or lost focus
(auto-save-mode -1)
(auto-save-visited-mode +1)
(defun save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all)

(require 'server)
(unless (server-running-p)
  (server-mode +1))

(eval-after-load "isearch" '(require 'isearch+))

(use-package diminish :ensure t)
(use-package magit :ensure t)
(use-package helpful :ensure t)
(use-package nerd-icons :ensure t)
(use-package wgrep :ensure t)
(use-package buffer-move :ensure t)
(use-package git-timemachine :ensure t)

(use-package dashboard :ensure t
  :init
  ;; (setq initial-buffer-choice 'dashboard-open)
  :config
  (dashboard-setup-startup-hook))

(use-package doom-modeline :ensure t
  :config
  (setq doom-modeline-height 32
        ;; doom-modeline-hud t
        doom-modeline-lsp t
        ;; doom-modeline-project-detection 'auto
        doom-modeline-minor-modes t
        doom-modeline-column-zero-based nil
        ;; doom-modeline-modal-icon t
        ;; doom-modeline-modal-modern-icon t
        doom-modeline-window-width-limit 76)
  (doom-modeline-mode +1))

(use-package which-key :ensure t
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
        which-key-add-column-padding 5
        which-key-max-description-length 32
        which-key-ellipsis "..."
        which-key-popup-type 'minibuffer
        ;; which-key-dont-use-unicode nil
        which-key-separator "  "
        ;; which-key-max-display-columns 5
        which-key-min-display-lines 8)
  (which-key-mode +1))

(use-package nerd-icons-dired :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion
  :ensure t
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup)
  :config
  (nerd-icons-completion-mode +1))

(use-package evil :ensure t
  ;; :preface  ;; this is now in early-init.el
  ;; (setq evil-want-keybinding nil
  ;;       evil-want-integration t)
  :custom
  (evil-undo-system 'undo-redo)
  (evil-want-fine-undo t)
  ;; (evil-respect-visual-line-mode t) ;; now using evil-better-visual-line.el
  :config
  ;; (evil-select-search-module 'evil-search-module 'evil-search)
  (unbind-key "<deletechar>" evil-normal-state-map) ;; DEL soll nicht ins Clipboard lÃ¶schen.
  (evil-mode +1))

(use-package evil-collection :ensure t
  :after evil
  :custom
  (evil-collection-corfu-key-themes '(default tab-n-go))
  :config
  (evil-collection-init)
  ;; (evil-collection-init '(corfu dashboard diff-hl dired eldoc elpaca lsp-ui-imenu which-key)))
  (diminish 'evil-collection-unimpaired-mode))

;; (use-package evil-nerd-commenter
;;   :demand t
;;   :diminish
;;   :after evil
;;   :bind ("C-#" . evilnc-comment-or-uncomment-lines))

(use-package evil-commentary :ensure t
  :demand t
  :diminish
  :after evil
  :bind ("C-#" . evil-commentary-line)
  :config
  (evil-commentary-mode +1))

(use-package evil-numbers :ensure t
  :config
  (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt))

(use-package evil-surround :ensure t
  :demand t
  :after evil
  :config
  (global-evil-surround-mode +1))

(use-package evil-goggles :ensure t
  :diminish
  :init
  (setq evil-goggles-duration 0.25)
  :custom-face
  (evil-goggles-yank-face ((t (:background "yellow"))))
  (evil-goggles-paste-face ((t (:background "blue"))))
  (evil-goggles-delete-face ((t (:background "red"))))
  (evil-goggles-default-face ((t (:background "green"))))
  :config
  (evil-goggles-use-diff-faces)
  (evil-goggles-mode +1))

;;  ;; Using RETURN to follow links in Org/Evil
;;  ;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
;;  (with-eval-after-load 'evil-maps
;;    (define-key evil-motion-state-map (kbd "SPC") nil)
;;    (define-key evil-motion-state-map (kbd "RET") nil)
;;    (define-key evil-motion-state-map (kbd "TAB") nil))
;;  ;; Setting RETURN key in org-mode to follow links
;;    (setq org-return-follows-link  t)

;; Enable Corfu completion UI
(use-package corfu :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-count 15)
  (corfu-min-width 25)
  (corfu-quit-at-boundary t)
  (corfu-quit-no-match t)
  (corfu-echo-delay 0.0)
  (corfu-preselect 'directory)
  (corfu-on-exact-match 'quit)
  (corfu-popupinfo-delay '(1.0 . 0.5))
  :init
  ;; (add-to-list 'savehist-additional-variables 'corfu-history)
  (global-corfu-mode +1)
  (corfu-popupinfo-mode +1)
  (corfu-history-mode +1))

(use-package nerd-icons-corfu :ensure t
  :demand t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Add extensions
(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
  )

(use-package vertico :ensure t
  :init
  (setq read-file-name-completion-ignore-case t
		read-buffer-completion-ignore-case t
		completion-ignore-case t
		eldoc-echo-area-use-multiline-p nil
		completion-styles '(flex partial-completion orderless)
        vertico-preselect 'prompt
		vertico-resize nil)
  :config
  (with-eval-after-load 'rfn-eshadow
    ;; This works with `file-name-shadow-mode' enabled.  When you are in
    ;; a sub-directory and use, say, `find-file' to go to your home '~/'
    ;; or root '/' directory, Vertico will clear the old path to keep
    ;; only your current input.
    (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy))
  (vertico-mode +1))

;; ;; Add prompt indicator to `completing-read-multiple'.
;; (defun crm-indicator (args)
;;   (cons (format "[CRM%s] %s"
;; 			    (replace-regexp-in-string
;; 			     "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
;; 			     crm-separator)
;; 			    (car args))
;; 		(cdr args)))
;; (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

(use-package orderless :ensure t
  :demand t
  :config
  (setq ;;completion-styles '(orderless partial-completion basic)
   completion-category-defaults nil
   completion-category-overrides nil))

(use-package counsel :ensure t)

(use-package consult :ensure t
  :demand t
  :hook
  (completion-list-mode . consult-preview-at-point-mode)
  (embark-collect-mode . consult-preview-at-point-mode)
  :custom
  ;; Use `consult-xref' for `xref-find-definitions'
  ;; NOTE: You can also set `xref-show-xrefs-function' to get the same behavior
  ;; for `xref-find-references'. However, I prefer listing references in a
  ;; separate buffer (default `xref-show-definitions-buffer')
  (xref-show-definitions-function #'consult-xref)

  :config
  (setq consult-line-numbers-widen t)
  (setq consult-preview-key 'any)
  (add-to-list 'consult-preview-allowed-hooks 'global-org-modern-mode-check-buffers)
  (consult-customize
   consult-theme consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.5 any)))

(use-package embark
  :ensure t
  :bind (([remap describe-bindings] . embark-bindings)
         ("C-." . embark-act) ; In a French AZERTY keyboard, the Â² key is right above TAB
         ("M-Â²" . embark-collect)
         ("M-." . embark-dwim))
  :init
  ;; Use Embark to show bindings in a key prefix with `C-h`
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult :ensure t)

(use-package marginalia :ensure t
  :config
  (marginalia-mode +1))

(add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)

(use-package format-all :ensure t
  :demand t
  :config
  (setq-default format-all-formatters '(("Emacs Lisp" (emacs-lisp))
                                        ("XML" (html-tidy "-xml" "-raw" "-indent" "-quiet" "-wrap" "0"))))
  )

(defun dual-format-function ()
  "Format code using lsp-format if lsp-mode is active, otherwise use format-all."
  (interactive)
  (if (bound-and-true-p lsp-mode)
	  (lsp-format-buffer)
	(format-all-region-or-buffer)))

(use-package dired-gitignore :ensure t
  :demand t
  :config
  (dired-gitignore-global-mode +1))

(use-package dimmer :ensure t
  :init
  (setq dimmer-fraction 0.45
	    dimmer-watch-frame-focus-events nil)

  (defun advise-dimmer-config-change-handler ()
	"Advise to only force process if no predicate is truthy."
	(let ((ignore (cl-some (lambda (f) (and (fboundp f) (funcall f)))
						   dimmer-prevent-dimming-predicates)))
	  (unless ignore
		(when (fboundp 'dimmer-process-all)
		  (dimmer-process-all t)))))

  (defun corfu-frame-p ()
	"Check if the buffer is a corfu frame buffer."
	(string-match-p "\\` \\*corfu" (buffer-name)))

  (defun dimmer-configure-corfu ()
	"Convenience settings for corfu users."
	(add-to-list 'dimmer-prevent-dimming-predicates #'corfu-frame-p))
  :config
  (advice-add 'dimmer-config-change-handler :override 'advise-dimmer-config-change-handler)
  (dimmer-configure-corfu)
  (dimmer-configure-which-key)
  (dimmer-configure-hydra)
  (dimmer-configure-org)
  (dimmer-configure-helm)
  (dimmer-configure-gnus)
  (dimmer-configure-posframe)
  (dimmer-configure-magit)
  (dimmer-mode +1))

(use-package centaur-tabs :ensure t
  :demand t
  ;; :hook
  ;; (server-after-make-frame . set-daemon-faces)
  ;; ((eshell-mode compilation-mode) . centaur-tabs-local-mode)
  :init
  (setq centaur-tabs-style "bar"
		centaur-tabs-set-bar 'under
		x-underline-at-descent-line t
		centaur-tabs-modified-marker "\u2022"
		centaur-tabs-height 32
		centaur-tabs-set-icons t
		centaur-tabs-set-modified-marker t
		centaur-tabs-cycle-scope 'tabs
		centaur-tabs-show-count t
		centaur-tabs-enable-ido-completion nil
		centaur-tabs-show-navigation-buttons nil
		centaur-tabs-show-new-tab-button t
		centaur-tabs-gray-out-icons 'buffer)
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project))

(use-package avy :ensure t
  :demand t
  :init
  (setq avy-timeout-seconds 0.45))

(use-package targets
  :load-path "~/.emacs.d/pkgs"
  :init
  (setq targets-user-text-objects '((double-quote "\"" nil quote :more-keys "q")))
  :config
  (targets-setup t))

(defalias 'my-kmacro-anwinfo
  (kmacro "/ a n w i n f o <return> <home> / b e n u t z e r i d = <return> w w v i \" p <home> / a n w = <return> w w c i \" A e n d <escape> <home> : s / i n - 0 / I N - / <return> & & & & & <home>"))

(add-hook 'nxml-mode-hook
          (lambda() (interactive)
            (define-key nxml-mode-map (kbd "C-Ã¶ w") 'my-kmacro-anwinfo)))

(use-package drag-stuff :ensure t
  :diminish
  :bind (("M-<up>" . drag-stuff-up)
         ("M-<down>" . drag-stuff-down)
         ;; ("M-<left>" . drag-stuff-left)
         ;; ("M-<right>" . drag-stuff-right)
         )
  :config
  (drag-stuff-global-mode +1))

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "M-<left>") 'evil-jump-backward)
(global-set-key (kbd "M-<right>") 'evil-jump-forward)

(use-package dired :ensure nil
  :diminish
  :init
  (setq dired-clean-confirm-killing-deleted-buffers nil
        dired-recursive-deletes 'top
        dired-recursive-copies  'always
        dired-create-destination-dirs 'ask)
  :commands
  (dired dired-jump)
  :config
  (put 'dired-find-alternate-file 'disabled nil)
  :custom
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-listing-switches "-lahFv --group-directories-first")
  (dired-dwim-target t)
  (dired-backup-overwrite t)

  (dired-auto-revert-buffer t)
  ;; (dired-free-space 'separate)
  (dired-hide-details-hide-symlink-targets nil)
  (delete-by-moving-to-trash t)
  (dired-omit-files (rx (seq bol "^.$"))) ;; Omit dot-self-dir file
  ;; (dired-omit-files (rx (seq bol "^\.$"))) ;; Omit dot-self-dir file
  ;; :bind
  ;; (:map dired-mode-map ("." . dired-omit-mode))
  ;; :hook
  ;; (dired-mode . dired-omit-mode)
  ;; (dired-mode . turn-off-evil-mode)
  )

(defun dired-find-parent-directory ()
  "Open a `dired'-buffer of the parent directory."
  (interactive)
  (find-alternate-file ".."))

(defun dired-arrow-keys-install ()
  "Install `dired-arrow-keys' by modifying `dired-mode-map'."
  (interactive)
  (define-key dired-mode-map (kbd "<right>") 'dired-find-file)
  (define-key dired-mode-map (kbd "<left>") 'dired-find-parent-directory)
  (eval-after-load 'evil
    '(progn
       (define-key dired-mode-map (vector 'remap 'evil-forward-char) 'dired-find-file)
       (define-key dired-mode-map (vector 'remap 'evil-backward-char) 'dired-find-parent-directory))))

(dired-arrow-keys-install)

;; ;;;; Handle performance for very long lines (so-long.el)
;; (use-package so-long :ensure nil
;;   :hook (after-init . global-so-long-mode))

(use-package dired-narrow :ensure t)
(use-package dired-preview :ensure t)

(use-package dired-subtree :ensure t
  :after dired
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package dired-rainbow
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#c17d11" ("log"))
    (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
    (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
    (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")))

;;;{{{ toggle between most recent buffers
;; http://www.emacswiki.org/emacs/SwitchingBuffers#toc5
(defun switch-to-last-used-buffer ()
  "Switch to most recent buffer. Repeated calls toggle back and forth between the most recent two buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
;;;}}}

(use-package general :ensure t
  :after evil
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer my-leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC" ;; access leader in insert mode
    )

  (my-leader-keys
    ;; "SPC" '(counsel-M-x :wk "Counsel M-x")
    "." '(find-file :wk "Find file")
    "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
    "SPC" '(switch-to-last-used-buffer :wk "Switch to last Buffer")
    ;; "SPC" '(evil-switch-to-windows-last-buffer :wk "Switch to last Buffer"))
    "u" '(universal-argument :wk "Universal argument"))

  (my-leader-keys
    "b" '(:ignore t :wk "Bookmarks/Buffers")
    ;; "b b" '(switch-to-buffer :wk "Switch to buffer")
    "b b" '(consult-buffer :wk "Switch to buffer")
    "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
    "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
    "b d" '(bookmark-delete :wk "Delete bookmark")
    "b e" '(eval-buffer :wk "Evaluate ELisp in Buffer")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-current-buffer :wk "Kill current buffer")
    "b K" '(kill-some-buffers :wk "Kill multiple buffers")
    "b l" '(list-bookmarks :wk "List bookmarks")
    "b m" '(bookmark-set :wk "Set bookmark")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
    "b R" '(rename-buffer :wk "Rename buffer")
    "b s" '(basic-save-buffer :wk "Save buffer")
    "b S" '(save-some-buffers :wk "Save multiple buffers")
    "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))

  (my-leader-keys
    "l" '(:ignore t :wk "Code")
    "lf" '(dual-format-function :wk "Format Buffer or Region"))

  (my-leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired")
    "d j" '(dired-jump :wk "Dired jump to current")
    "d n" '(neotree-dir :wk "Open directory in neotree")
    "d ." '(dired-omit-mode :wk "Toggle hidden Files")
    "d p" '(peep-dired :wk "Peep-dired"))

  (my-leader-keys
    "e" '(:ignore t :wk "Eshell/Evaluate")
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e h" '(counsel-esh-history :which-key "Eshell history")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e R" '(eww-reload :which-key "Reload current page in EWW")
    "e s" '(eshell :which-key "Eshell")
    "e w" '(eww :which-key "EWW emacs web wowser"))

  (my-leader-keys
    "f" '(:ignore t :wk "Files")
    "f f" '(find-file :wk "Find file")
    ;; "f D" '(dirvish-side :wk "Dirvish")
    "f c" '((lambda () (interactive)
              (find-file "~/.emacs.d/config.el"))
            :wk "Open User-Config File")
    "f e" '((lambda () (interactive)
              (dired "~/.emacs.d/"))
            :wk "Open user-emacs-directory in dired")
    "f d" '(find-grep-dired :wk "Search for string in files in DIR")
    "f j" '(counsel-file-jump :wk "Jump to a File below current Directory")
    "f l" '(counsel-locate :wk "Locate a File")
    "f r" '(counsel-recentf :wk "Find recent Files")
    ;; "f u" '(sudo-edit-find-file :wk "Sudo find file")
    ;; "f U" '(sudo-edit :wk "Sudo edit file")
    )

  (my-leader-keys
    "g" '(:ignore t :wk "Git")
    "g b" '(magit-branch-checkout :wk "Switch Branch")
    "g B" '(magit-branch-and-checkout :wk "Create Branch and Checkout")
    "g c" '(:ignore t :wk "Create")
    "g c c" '(magit-commit-create :wk "Create Commit")
    "g c f" '(magit-commit-fixup :wk "Create fixup Commit")
    "g C" '(magit-clone :wk "Clone Repo")
    "g d" '(:ignore t :wk "Dispatch")
    "g d d" '(magit-dispatch :wk "Magit dispatch")
    "g d f" '(magit-file-dispatch :wk "Magit File Dispatch")
    "g f" '(:ignore t :wk "Find")
    "g f c" '(magit-show-commit :wk "Show Commit")
    "g f f" '(magit-find-file :wk "Git find File")
    "g f g" '(magit-find-git-config-file :wk "Find Gitconfig File")
    "g F" '(magit-pull :wk "Git Pull")
    "g P" '(magit-push :wk "Git Push")
    "g g" '(magit-status :wk "Git Status")
    "g i" '(magit-init :wk "Initialize Git Repo")
    ;; "g l" '(magit-log-buffer-file :wk "Magit Buffer Log")
    "g l" '(magit-log :wk "Git Log")
    "g r" '(vc-revert :wk "Git revert File")
    "g v" '(vc-next-action :wk "VC next Action")
    "g s" '(magit-stage-file :wk "Git stage File")
    "g t" '(git-timemachine :wk "Git time Machine")
    "g u" '(magit-stage-file :wk "Git unstAge File"))

  (my-leader-keys
    "h" '(:ignore t :wk "Help")
    "h a" '(counsel-apropos :wk "Apropos")
    "h b" '(describe-bindings :wk "Describe bindings")
    "h c" '(describe-char :wk "Describe character under cursor")
    "h d" '(:ignore t :wk "Emacs documentation")
    "h d a" '(about-emacs :wk "About Emacs")
    "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
    "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
    "h d m" '(info-emacs-manual :wk "The Emacs manual")
    "h d n" '(view-emacs-news :wk "View Emacs news")
    "h d o" '(describe-distribution :wk "How to obtain Emacs")
    "h d p" '(view-emacs-problems :wk "View Emacs problems")
    "h d t" '(view-emacs-todo :wk "View Emacs todo")
    "h d w" '(describe-no-warranty :wk "Describe no warranty")
    "h e" '(view-echo-area-messages :wk "View echo area messages")
    "h f" '(helpful-function :wk "Describe function")
    "h F" '(describe-face :wk "Describe face")
    "h g" '(describe-gnu-project :wk "Describe GNU Project")
    "h i" '(info :wk "Info")
    "h h" '(helpful-at-point :wk "Helpful at Point")
    "h I" '(describe-input-method :wk "Describe input method")
    "h k" '(helpful-key :wk "Describe key")
    "h s" '(shortdoc :wk "Short Documentation")
    "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
    "h L" '(describe-language-environment :wk "Describe language environment")
    "h m" '(describe-mode :wk "Describe mode")
    "h t" '(load-theme :wk "Load theme")
    "h v" '(helpful-variable :wk "Describe variable")
    "h w" '(where-is :wk "Prints keybinding for command if set")
    "h x" '(describe-command :wk "Display full documentation for command"))

  (my-leader-keys
    "RET" '(avy-goto-char-timer :wk "Easy Jump"))

  (my-leader-keys
    "m" '(:ignore t :wk "Org")
    "m a" '(org-agenda :wk "Org Agenda")
    "m x" '(org-export-dispatch :wk "Org Export Dispatch")
    "m i" '(org-toggle-item :wk "Org Toggle Item")
    "m e" '(org-edit-special :wk "Edit Block at Point")
    "m t" '(org-todo :wk "Org Todo")
    "m B" '(org-babel-tangle :wk "Org Babel Tangle")
    "m T" '(org-todo-list :wk "Org Todo List"))

  (my-leader-keys
    "m b" '(:ignore t :wk "Tables")
    "m b -" '(org-table-insert-hline :wk "Insert hline in Table"))

  (my-leader-keys
    "m d" '(:ignore t :wk "Date/Deadline")
    "m d t" '(org-time-stamp :wk "Org time stamp"))

  (my-leader-keys
    "o" '(:ignore t :wk "Open")
    "o d" '(dashboard-open :wk "Dashboard")
    "o e" '(elfeed :wk "Elfeed RSS")
    "o f" '(make-frame :wk "Open buffer in new frame")
    "o F" '(select-frame-by-name :wk "Select frame by name"))

  ;; projectile-command-map already has a ton of bindings
  ;; set for us, so no need to specify each individually.
  (my-leader-keys
    ;; "SPC" '(projectile-find-file :wk "Project find File")
    "p" '(projectile-command-map :wk "Projectile"))

  ;; (my-leader-keys
  ;;   "p" '(:ignore t :wk "Project")
  ;;   "p x" '(projectile-command-map :wk "Projectile")
  ;;   "p d" '(project-dired :wk "project-dired")
  ;;   "p b" '(project-switch-to-buffer :wk "project-switch-to-buffer")
  ;;   "p e" '(project-eshell :wk "project-eshell")
  ;;   "p f" '(project-find-file :wk "project-find-file")
  ;;   "p p" '(project-switch-project :wk "project-switch-project")
  ;;   "p v" '(project-vc-dir :wk "project-vc-dir")
  ;;   "p !" '(project-shell-command :wk "Shell Command"))

  (my-leader-keys
    "s" '(:ignore t :wk "Search")
    "s l" '(consult-line :wk "Search in Lines")
    "s i" '(consult-imenu :wk "Imenu")
    "s o" '(occur :wk "Occurrence")
    "s g" '(consult-ripgrep :wk "consult-ripgrep: in Files curr. Dir")
    "s s" '(counsel-grep-or-swiper :wk "Swiper or Grep")
    "s G" '(counsel-rg :wk "counsel-ripgrep: in Files curr. Dir")
    "s r" '(rg-menu :wk "RipGrep dwim")
    "s d" '(dictionary-search :wk "Search dictionary")
    "s t" '(tldr :wk "Lookup TLDR docs for a command")
    ;; "s m" '(man :wk "Search Man Pages")
    "s m" '(woman :wk "Man Pages (w/o man)"))

  (my-leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t e" '(eshell-toggle :wk "Toggle eshell")
    "t f" '(flycheck-mode :wk "Toggle flycheck")
    "t n" '(display-line-numbers-mode :wk "Toggle line Numbers")
    "t o" '(org-mode :wk "Toggle Org Mode")
    "t r" '(rainbow-mode :wk "Toggle Rainbow Mode")
    "t t" '(visual-line-mode :wk "Toggle Truncated Lines")
    "t v" '(vterm-toggle :wk "Toggle VTerm"))

  (my-leader-keys
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w k" '(evil-window-delete :wk "Kill Window")
    "w c" '(evil-window-new :wk "Create new Window")
    "w f" '(make-frame :wk "Open buffer in new frame")
    "w s" '(evil-window-split :wk "Horizontal split Window")
    "w v" '(evil-window-vsplit :wk "Vertical split Window")
    ;; Window motions
    "w <left>" '(evil-window-left :wk "Window left")
    "w <down>" '(evil-window-down :wk "Window down")
    "w <up>" '(evil-window-up :wk "Window up")
    "w <right>" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next Window")
    "w n" '(evil-window-next :wk "Goto next Window")
    "w p" '(evil-window-prev :wk "Goto previous Window")
    ;; Move Windows
    "w r" '(evil-window-rotate-downwards :wk "Rotate downwards")
    "w M-<left>" '(buf-move-left :wk "Buffer move left")
    "w M-<down>" '(buf-move-down :wk "Buffer move down")
    "w M-<up>" '(buf-move-up :wk "Buffer move up")
    "w M-<right>" '(buf-move-right :wk "Buffer move right"))
  )

(use-package fzf
  :bind
  ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))

;; (use-package projection
;;   :ensure t
;;   :hook (after-init . global-projection-hook-mode)
;;   :config
;;   (with-eval-after-load 'project
;;     (require 'projection))
;;   ;; Uncomment if you want to disable prompts for compile commands customized in .dir-locals.el
;;   ;; (put 'projection-commands-configure-project 'safe-local-variable #'stringp)
;;   ;; (put 'projection-commands-build-project 'safe-local-variable #'stringp)
;;   ;; (put 'projection-commands-test-project 'safe-local-variable #'stringp)
;;   ;; (put 'projection-commands-run-project 'safe-local-variable #'stringp)
;;   ;; (put 'projection-commands-package-project 'safe-local-variable #'stringp)
;;   ;; (put 'projection-commands-install-project 'safe-local-variable #'stringp)
;;
;;   ;; Access pre-configured projection commands from a keybinding of your choice.
;;   ;; Run `M-x describe-keymap projection-map` for a list of available commands.
;;   :bind-keymap
;;   ("C-x P" . projection-map))

;; (use-package projection-multi
;;   :ensure t
;;   ;; Allow interactively selecting available compilation targets from the current
;;   ;; project type.
;;   :bind ( :map project-prefix-map
;;           ("RET" . projection-multi-compile)))

;; (use-package projection-multi-embark
;;   :ensure t
;;   :after embark
;;   :after projection-multi
;;   :demand t
;;   ;; Add the projection set-command bindings to `compile-multi-embark-command-map'.
;;   :config (projection-multi-embark-setup-command-map))

(use-package projectile
  :ensure t
  :diminish
  ;; :bind (:map projectile-mode-map
  ;;             ("s-p" . projectile-command-map)
  ;;             ("C-c p" . projectile-command-map))
  :config
  (projectile-mode +1))

(use-package js2-mode :ensure t
  :mode "\\.js\\'"
  :custom
  (js2-include-node-externs t)
  (js2-highlight-level 3)
  ;; (js2r-prefer-let-over-var t)
  (js2r-prefered-quote-type 2)
  (js-indent-align-list-continuation t)
  (global-auto-highlight-symbol-mode t)
  :config
  (setq js-indent-level 2))

(use-package powershell
  :mode ("\\.ps1\\'" . powershell-mode))

(use-package color-identifiers-mode :ensure t
  :config
  (global-color-identifiers-mode +1))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package yasnippet
  :config (yas-global-mode +1))
(use-package java-snippets)
(use-package yasnippet-snippets)

(use-package flycheck)

(use-package lsp-java-lombok
  :load-path "~/.emacs.d/pkgs")

(use-package lsp-mode
  :custom
  (lsp-log-io nil)
  (lsp-idle-delay 1.0) ;; how often lsp-mode will refresh the highlights, lenses, links, etc while you type.
  (lsp-keymap-prefix "SPC l")
  :hook ((java-ts-mode . lsp) ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (java-ts-mode . lsp-java-lombok/init)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (general-def 'normal lsp-mode :definer 'minor-mode lsp-keymap-prefix lsp-command-map))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-modeline-code-action-fallback-icon "î´") ;; ïƒ«  îª†  î­­  î´
  ;; (lsp-modeline-code-actions-segments '(count name))
  :config
  ;; (when (display-graphic-p)
  ;;   (setq lsp-ui-doc-use-webkit t))
  )

(use-package lsp-java
  :after lsp-mode
  :custom
  (lsp-java-workspace-dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/workspace/"))
  (lsp-java-server-install-dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/server/"))
  (lsp-java-vmargs '("-Xmx2G" "-Xms1G" "-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true"))
  :config
  (add-hook 'java-mode-hook 'lsp))

(use-package dap-mode)
(use-package dap-java :ensure nil)
(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)

(add-hook 'occur-hook
          '(lambda () (switch-to-buffer-other-window "*Occur*")))

(use-package rg
  :custom
  (rg-executable (if (eq system-type 'windows-nt)
                     "c:/scoop/apps/ripgrep/current/rg.exe"
                   "rg"))
  :hook
  (rg-mode . (lambda () (switch-to-buffer-other-window "*rg*")))
  (rg-mode . wgrep-rg-setup))

(use-package golden-ratio
  :diminish
  :config
  (golden-ratio-mode +1))

(use-package evil-better-visual-line
  :load-path "~/.emacs.d/pkgs"
  :config
  (evil-better-visual-line-on))

(use-package csv-mode
  :mode ("\\.[Cc][Ss][Vv]\\'" . csv-mode)
  :hook (csv-mode . csv-guess-set-separator))

;; https://github.com/matsievskiysv/vimish-fold
;; https://github.com/jaalto/project-emacs--folding-mode
;; https://emacs.stackexchange.com/questions/37363/vim-triple-braces-code-folding-in-emacs

;; (use-package origami :ensure t)
