;;; init.el --- Init -*- no-byte-compile: t; lexical-binding: t; -*-

;; Author: James Cherti
;; URL: https://github.com/jamescherti/minimal-emacs.d
;; Package-Requires: ((emacs "29.1"))
;; Keywords: maint
;; Version: 1.1.0
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:
;; The minimal-emacs.d project is a customizable base that provides better Emacs
;; defaults and optimized startup, intended to serve as a solid foundation for
;; your vanilla Emacs configuration.

;;; Code:

;;; Networking

;; Don't ping things that look like domain names.
(setq ffap-machine-p-known 'reject)

;;; package.el
(when (bound-and-true-p minimal-emacs-package-initialize-and-refresh)
  ;; Initialize and refresh package contents again if needed
  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))

  ;; Install use-package if necessary
  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  ;; Ensure use-package is available at compile time
  (eval-when-compile
    (require 'use-package)))

;;; Features, warnings, and errors

;; Disable warnings from the legacy advice API. They aren't useful.
(setq ad-redefinition-action 'accept)

(setq warning-suppress-types '((lexical-binding)))

;; Some features that are not represented as packages can be found in
;; `features', but this can be inconsistent. The following enforce consistency:
(if (fboundp #'json-parse-string)
    (push 'jansson features))
(if (string-match-p "HARFBUZZ" system-configuration-features) ; no alternative
    (push 'harfbuzz features))
(if (bound-and-true-p module-file-suffix)
    (push 'dynamic-modules features))

;;; Minibuffer
;; Allow nested minibuffers
(setq enable-recursive-minibuffers t)

;; Keep the cursor out of the read-only portions of the minibuffer
(setq minibuffer-prompt-properties
      '(read-only t intangible t cursor-intangible t face
                  minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;;; User interface

;; By default, Emacs "updates" its ui more often than it needs to
(setq idle-update-delay 1.0)

;; Allow for shorter responses: "y" for yes and "n" for no.
(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (advice-add #'yes-or-no-p :override #'y-or-n-p))
(defalias #'view-hello-file #'ignore)  ; Never show the hello file

;;; Misc

;; switch-to-buffer runs pop-to-buffer-same-window instead
(setq switch-to-buffer-obey-display-actions t)

(setq show-paren-delay 0.25
      show-paren-highlight-openparen t
      show-paren-when-point-inside-paren t
      show-paren-when-point-in-periphery t)

(setq whitespace-line-column nil)  ; whitespace-mode

;; I reduced the default value of 9 to simplify the font-lock keyword,
;; aiming to improve performance. This package helps differentiate
;; nested delimiter pairs, particularly in languages with heavy use of
;; parentheses.
(setq rainbow-delimiters-max-face-count 5)

(setq comint-prompt-read-only t)
(setq comint-buffer-maximum-size 2048)

(setq compilation-always-kill t
      compilation-ask-about-save nil
      compilation-scroll-output 'first-error)

(setq truncate-string-ellipsis "…")

;; Delete by moving to trash in interactive mode
(setq delete-by-moving-to-trash (not noninteractive))

;; Increase how much is read from processes in a single chunk (default is 4kb).
(setq read-process-output-max (* 1024 1024))  ; 1mb

;;; Files

;; Disable the warning "X and Y are the same file". Ignoring this warning is
;; acceptable since it will redirect you to the existing buffer regardless.
(setq find-file-suppress-same-file-warnings t)

;; Resolve symlinks when opening files, so that any operations are conducted
;; from the file's true directory (like `find-file').
(setq find-file-visit-truename t
      vc-follow-symlinks t)

;; Prefer vertical splits over horizontal ones
(setq split-width-threshold 168
      split-height-threshold nil)

;; The native border "uses" a pixel of the fringe on the rightmost
;; splits, whereas `window-divider` does not.
(setq window-divider-default-bottom-width 1
      window-divider-default-places t
      window-divider-default-right-width 1)

(add-hook 'after-init-hook #'window-divider-mode)

;;; Backup files

(setq backup-directory-alist
      `(("." . ,(expand-file-name "backup" user-emacs-directory))))
(setq tramp-backup-directory-alist backup-directory-alist)
(setq backup-by-copying-when-linked t)
(setq backup-by-copying t)  ; Backup by copying rather renaming
(setq delete-old-versions t)  ; Delete excess backup versions silently
(setq version-control t)  ; Use version numbers for backup files
(setq kept-new-versions 5)
(setq kept-old-versions 5)
(setq vc-make-backup-files nil)  ; Do not backup version controlled files

;;; Auto save
;; Enable auto-save to safeguard against crashes or data loss. The
;; `recover-file' or `recover-session' functions can be used to restore
;; auto-saved data.
(setq auto-save-default t)

;; Do not auto-disable auto-save after deleting large chunks of
;; text. The purpose of auto-save is to provide a failsafe, and
;; disabling it contradicts this objective.
(setq auto-save-include-big-deletions t)

(setq auto-save-list-file-prefix
      (expand-file-name "autosave/" user-emacs-directory))
(setq tramp-auto-save-directory
      (expand-file-name "tramp-autosave/" user-emacs-directory))

;; Auto save options
(setq kill-buffer-delete-auto-save-files t)

;;; Auto revert
;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(setq revert-without-query (list ".")  ; Do not prompt
      auto-revert-verbose t
      auto-revert-stop-on-user-input nil)

;; Revert other buffers (e.g, Dired)
(setq global-auto-revert-non-file-buffers t)

;;; recentf
;; `recentf' is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(setq recentf-max-saved-items 60) ; default is 20
(setq recentf-auto-cleanup 'mode)

;;; saveplace
;; `save-place-mode` enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(setq save-place-file (expand-file-name "saveplace" user-emacs-directory))
(setq save-place-limit 600)

;;; savehist
;; `savehist` is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(setq history-length 300)
(setq savehist-save-minibuffer-history t)  ;; Default

;;; Frames and windows

;; Resizing the Emacs frame can be costly when changing the font. Disable this
;; to improve startup times with fonts larger than the system default.
(setq frame-resize-pixelwise nil)

;; However, do not resize windows pixelwise, as this can cause crashes in some
;; cases when resizing too many windows at once or rapidly.
(setq window-resize-pixelwise nil)

(setq resize-mini-windows 'grow-only)

;;; Scrolling
;; Enables faster scrolling through unfontified regions. This may result in
;; brief periods of inaccurate syntax highlighting immediately after scrolling,
;; which should quickly self-correct.
(setq fast-but-imprecise-scrolling t)

;; Move point to top/bottom of buffer before signaling a scrolling error.
(setq scroll-error-top-bottom t)

;; Keeps screen position if the scroll command moved it vertically out of the
;; window.
(setq scroll-preserve-screen-position t)

;;; Mouse

;; Emacs 29
(when (memq 'context-menu minimal-emacs-ui-features)
  (when (and (display-graphic-p) (fboundp 'context-menu-mode))
    (add-hook 'after-init-hook #'context-menu-mode)))

(setq hscroll-margin 5
      hscroll-step 1
      ;; Emacs spends excessive time recentering the screen when the cursor
      ;; moves more than N lines past the window edges (where N is the value of
      ;; `scroll-conservatively`). This can be particularly slow in larger files
      ;; during extensive scrolling. If `scroll-conservatively` is set above
      ;; 100, the window is never automatically recentered. The default value of
      ;; 0 triggers recentering too aggressively. Setting it to 10 reduces
      ;; excessive recentering and only recenters the window when scrolling
      ;; significantly off-screen.
      scroll-conservatively 10
      scroll-preserve-screen-position t
      ;; Reduce cursor lag by preventing automatic adjustments to
      ;; `window-vscroll' for unusually long lines. Setting
      ;; `auto-window-vscroll' it to nil also resolves the issue of random
      ;; half-screen jumps during scrolling.
      auto-window-vscroll nil
      ;; Mouse
      mouse-wheel-scroll-amount '(1 ((shift) . hscroll))
      mouse-wheel-scroll-amount-horizontal 1)

;;; Cursor
;; The blinking cursor is distracting and interferes with cursor settings in
;; some minor modes that try to change it buffer-locally (e.g., Treemacs).
;; Additionally, it can cause freezing, especially on macOS, for users with
;; customized and colored cursors.
(blink-cursor-mode +1)

;; Don't blink the paren matching the one at point, it's too distracting.
(setq blink-matching-paren nil)

;; Don't stretch the cursor to fit wide characters,
;; it is disorienting, especially for tabs.
(setq x-stretch-cursor nil)

;; Reduce rendering/line scan work by not rendering cursors or regions in
;; non-focused windows.
(setq highlight-nonselected-windows nil)

;;; Annoyances

;; No beeping or blinking
(setq ring-bell-function #'ignore)

;; This controls how long Emacs will blink to show the deleted pairs with
;; `delete-pair'. A longer delay can be annoying as it causes a noticeable pause
;; after each deletion, disrupting the flow of editing.
(setq delete-pair-blink-delay 0.05)

;;; Indent and formatting
(setq-default left-fringe-width  8)
(setq-default right-fringe-width 8)

;; Do not show an arrow at the top/bottomin the fringe and empty lines
(setq-default indicate-empty-lines nil)
(setq-default indicate-buffer-boundaries nil)

;; Continue wrapped lines at whitespace rather than breaking in the
;; middle of a word.
(setq-default word-wrap t)

;; Disable wrapping by default due to its performance cost.
(setq-default truncate-lines t)

;; If enabled and `truncate-lines' is disabled, soft wrapping will not occur
;; when the window is narrower than `truncate-partial-width-windows' characters.
(setq truncate-partial-width-windows nil)

;; Enable multi-line commenting which ensures that `comment-indent-new-line'
;; properly continues comments onto new lines, which is useful for writing
;; longer comments or docstrings that span multiple lines.
(setq comment-multi-line t)

;; Disable the obsolete practice of end-of-line spacing from the
;; typewriter era.
(setq sentence-end-double-space nil)

;; According to the POSIX, a line is defined as "a sequence of zero or
;; more non-newline characters followed by a terminating newline".
(setq require-final-newline t)

;; Remove duplicates from the kill ring to reduce clutter
(setq kill-do-not-save-duplicates t)

;; Ensures that empty lines within the commented region are also commented out.
;; This prevents unintended visual gaps and maintains a consistent appearance,
;; ensuring that comments apply uniformly to all lines, including those that are
;; otherwise empty.
(setq comment-empty-lines t)

;;; Mode line

;; Setting `display-time-default-load-average' to nil makes Emacs omit the load
;; average information from the mode line.
(setq display-time-default-load-average nil)

;; Display the current line and column numbers in the mode line
(setq line-number-mode t)
(setq column-number-mode t)

;;; Filetype

;; Do not notify the user each time Python tries to guess the indentation offset
(setq python-indent-guess-indent-offset-verbose nil)

(setq sh-indent-after-continuation 'always)

;;; Font / Text scale

;; Avoid automatic frame resizing when adjusting settings.
(setq global-text-scale-adjust-resizes-frames nil)

;;; Ediff

;; Configure Ediff to use a single frame and split windows horizontally
(setq ediff-window-setup-function #'ediff-setup-windows-plain
      ediff-split-window-function #'split-window-horizontally)

;;; Load post-init.el
;;(minimal-emacs-load-user-init "user-config.el")
(load (expand-file-name "config.el" user-emacs-directory))

(provide 'init)

;;; init.el ends here
