(require 'cl)

;; Disable start screen.
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Disable toolbar.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Require a newline at the end of line.
(setq require-final-newline t)

(setq show-trailing-whitespace t)

;; Scroll one line at a time
(setq scroll-conservatively 10000)

;; Automatic line breaks
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Avoid cluttering the current directory with temp files
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(set-frame-font "DejaVu Sans Mono-10")
(setq default-frame-alist '((font . "DejaVu Sans Mono-10")))

;; Show matching parens (mixed style)
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)

;; y/n vs yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Automatic closing of parenthesis, etc.
(electric-pair-mode 1)
;; (electric-indent-mode 1)
(semantic-mode 1)

;; Jump to the first error.
(global-set-key (kbd "M-g M-f") 'first-error)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ("melpa" . "http://melpa.milkbox.net/packages/")
        ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
        ))

(autoload 'package-initialize "package" nil t)
(package-initialize)

(autoload 'color-theme-initialize "color-theme" nil t)
(color-theme-initialize)
(load-theme 'solarized t)

(autoload 'powerline-default-theme "powerline" nil t)
(add-hook 'after-init-hook 'powerline-default-theme)

;; Enable line numbers on the left (global-linum-mode is super slow, use nlinum instead).
(global-nlinum-mode t)

;; Don't use autoload/eval-after-load - this should be available from the start.
(autoload 'evil-leader "evil-leader" nil t)
(eval-after-load "evil-leader"
  '(progn
     (setq evil-leader/in-all-states 1)
     (evil-leader/set-leader ",")
     (evil-leader/set-key "g" 'helm-projectile-ag)
     (evil-leader/set-key "t" 'helm-projectile)
     (evil-leader/set-key "f" 'helm-find-files)
     (evil-leader/set-key "k" 'helm-show-kill-ring)
     (evil-leader/set-key "m" 'helm-mini)
     (evil-leader/set-key "n" 'helm-occur)
     (evil-leader/set-key "h" 'helm-semantic-or-imenu)
     (evil-leader/set-key "d" 'helm-projectile-switch-project)
     (evil-leader/set-key "c" 'evilnc-comment-or-uncomment-lines)
     (evil-leader/set-key "," 'ace-jump-mode)
     )
  )
(add-hook 'after-init-hook 'global-evil-leader-mode)

(autoload 'evil "evil" nil t)
(eval-after-load "evil"
  '(progn
    (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-normal-state-map (kbd "C-d") 'evil-scroll-down)
    )
  )
(add-hook 'after-init-hook (lambda () (evil-mode 1)))

(autoload 'evil-surround "evil-surround" nil t)
(add-hook 'prog-mode-hook 'global-evil-surround-mode)

(autoload 'evil-jumper "evil-jumper" nil t)
(add-hook 'prog-mode-hook 'turn-on-evil-jumper-mode)

(autoload 'evil "evil-nerd-commenter" nil t)
(add-hook 'prog-mode-hook 'evilnc-default-hotkeys)

(autoload 'undo-tree "undo-tree" nil t)
(eval-after-load "undo-tree"
  '(progn
     (setq undo-tree-auto-save-history 1)
     )
  )
(add-hook 'after-init-hook 'global-undo-tree-mode)

(autoload 'helm "helm" nil t)
(autoload 'helm-config "helm-config" nil t)
(autoload 'helm-projectile "helm-projectile" nil t)
(autoload 'helm-ag "helm-ag" nil t)
(autoload 'helm-semantic "helm-semantic" nil t)
(eval-after-load "helm"
  '(progn
     ;; Change he default "C-x c" to "C-c h"
     (global-unset-key (kbd "C-x c"))
     (global-set-key (kbd "C-c h") 'helm-command-prefix)
     (global-set-key (kbd "C-x b") 'helm-mini)
     (global-set-key (kbd "C-0") 'helm-etags-select)
     (setq helm-M-x-fuzzy-match t
           helm-apropos-fuzzy-match t
           helm-ag-fuzzy-match t
           helm-ag-insert-at-point 'symbol
           helm-buffers-fuzzy-matching t
           helm-imenu-fuzzy-match t
           helm-lisp-fuzzy-completion t
           helm-locate-fuzzy-match t
           helm-recentf-fuzzy-match t
           helm-semantic-fuzzy-match t)
     (helm-mode 1)
     )
  )
(global-set-key (kbd "M-x") 'helm-M-x)

(autoload 'projectile "projectile" nil t)
(eval-after-load "projectile"
  '(progn
     (setq projectile-indexing-method 'alien
           projectile-enable-caching t
           projectile-completion-system 'helm
           projectile-globally-ignored-files
           (append '("*.o" "*.dyn_hi" "*.dyn_o" "*.hi" "*.pyc")
                   projectile-globally-ignored-files)
           projectile-globally-ignored-directories
           (append '(".svn" "/dist/")
                   projectile-globally-ignored-directories))
     (projectile-global-mode)
     (helm-projectile-on)
     )
  )

(autoload 'global-flycheck-mode "flycheck" nil t)
(autoload 'flycheck-haskell "flycheck-haskell" nil t)
(eval-after-load "haskell-mode"
  '(progn
     (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)))
(add-hook 'prog-mode-hook 'global-flycheck-mode)

(autoload 'global-company-mode "company" nil t)
(autoload 'company-ghc "company-ghc" nil t)
(eval-after-load "company"
  '(progn
     (setq company-idle-delay 0
           company-tooltip-limit 20
           company-minimum-prefix-length 2
           company-show-numbers 1)
     (define-key company-active-map (kbd "C-n") 'company-select-next)
     (define-key company-active-map (kbd "C-p") 'company-select-previous)
     (define-key global-map (kbd "C-.") 'company-files)
     (add-to-list 'company-backends 'company-files)
     (add-to-list 'company-backends 'company-ghc)
     )
  )
(add-hook 'prog-mode-hook 'global-company-mode)

;; Indentation: default 4 spaces...
(setq-default tab-width 4 indent-tabs-mode nil)
;; ... and detect the already existing indentation style.
(autoload 'dtrt-indent-mode "dtrt-indent" nil t)
(add-hook 'prog-mode-hook (lambda () (dtrt-indent-mode 1)))

;; haskell stuff
(autoload 'ghc "ghc" nil t)
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'hindent "hindent" nil t)
(autoload 'hi2 "hi2" nil t)
(autoload 'ghc-init "ghc-init" nil t)
(autoload 'ghc-debug "ghc-debug" nil t)
(eval-after-load "haskell-mode"
  '(progn
     (add-hook 'haskell-mode-hook 'ghc-init)
     (add-hook 'haskell-mode-hook 'hindent-mode)
     (add-hook 'haskell-mode-hook 'haskell-simple-indent-mode)
     (add-hook 'haskell-mode-hook 'clean-aindent-mode)
     (setq haskell-indent-spaces 4)
     (setq hindent-style "johan-tibell")
     )
  )

(autoload 'newline-and-indent "clean-aindent-mode" nil t)
(eval-after-load "clean-aindent-mode"
  '(progn
     (set 'clean-aindent-is-simple-indent t)
     (define-key global-map (kbd "S-<tab>") 'clean-aindent--bsunindent)
     )
  )
(define-key global-map (kbd "RET") 'newline-and-indent)

(autoload 'expand-region "expand-region" nil t)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(autoload 'highlight-symbol "highlight-symbol" nil t)
(eval-after-load "highlight-symbol"
  '(progn
     (setq highlight-symbol-idle-delay 0.5)
     )
  )
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

(autoload 'uniquify "uniquify" nil t)
(eval-after-load "uniquify"
  '(progn
     (setq uniquify-buffer-name-style 'post-forward
           uniquify-separator ":")
     )
  )
;; (add-hook 'prog-mode-hook 'uniquify)

(autoload 'yasnippet "yasnippet" nil t)
(eval-after-load "yasnippet"
  '(progn
     (yas-global-mode 1)
     )
  )

(autoload 'global-whitespace-cleanup-mode "whitespace-cleanup-mode" nil t)
(add-hook 'after-init-hook 'global-whitespace-cleanup-mode)
