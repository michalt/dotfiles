;; Disable start screen.
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Disable toolbar.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Require a newline at the end of line.
(setq require-final-newline t)

;; Scroll one line at a time
(setq scroll-conservatively 10000)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ("melpa" . "http://melpa.milkbox.net/packages/")
        ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
        ))

(require 'package)
(package-initialize)

(require 'color-theme)
(color-theme-initialize)
(load-theme 'solarized t)

(set-frame-font "DejaVu Sans Mono-10")
(setq default-frame-alist '((font . "DejaVu Sans Mono-10")))

;; Note: this should be before evil itself
(require 'evil-leader)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key "g" 'helm-projectile-ag)
(evil-leader/set-key "t" 'helm-projectile)
(evil-leader/set-key "f" 'helm-find-files)
(evil-leader/set-key "k" 'helm-show-kill-ring)
(evil-leader/set-key "m" 'helm-mini)
(evil-leader/set-key "n" 'helm-occur)
(evil-leader/set-key "h" 'helm-semantic-or-imenu)
(evil-leader/set-key "c" 'evilnc-comment-or-uncomment-lines)
(evil-leader/set-key "," 'ace-jump-mode)

;; doesn't seem to work: (setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-jumper)
(turn-on-evil-jumper-mode)

(require 'elisp-slime-nav)
(defun my-lisp-hook ()
  (elisp-slime-nav-mode)
  (eldoc-mode)
  )
(add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
(evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
  'elisp-slime-nav-describe-elisp-thing-at-point)

(require 'undo-tree)
(setq undo-tree-auto-save-history 1)

(require 'helm-config)
(require 'helm-projectile)
(require 'helm-ag)
(require 'helm-semantic)
;; Change he default "C-x c" to "C-c h"
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-0") 'helm-etags-select)
(setq helm-M-x-fuzzy-match t
      helm-apropos-fuzzy-match t
      helm-ag-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-imenu-fuzzy-match t
      helm-lisp-fuzzy-completion t
      helm-locate-fuzzy-match t
      helm-recentf-fuzzy-match t
      helm-semantic-fuzzy-match t)
(helm-mode 1)

(require 'projectile)
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(setq projectile-globally-ignored-files
      (append '("*.o" "*.dyn_hi" "*.dyn_o" "*.hi" "*.pyc")
              projectile-globally-ignored-files))
(setq projectile-globally-ignored-directories
      (append '(".svn" "/dist/") projectile-globally-ignored-directories))
(projectile-global-mode)

(helm-projectile-on)

;; Automatic closing of parenthesis, etc.
(electric-pair-mode 1)
(electric-indent-mode 0)
(semantic-mode 1)

(require 'dired-x)

(require 'flycheck)
(require 'flycheck-haskell)
(global-flycheck-mode)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

(require 'company)
(setq company-idle-delay 0
      company-tooltip-limit 20
      company-minimum-prefix-length 2
      company-show-numbers 1)
(global-company-mode)
(add-to-list 'company-backends 'company-files)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key global-map (kbd "C-.") 'company-files)

;; Indentation: default 4 spaces...
(setq-default tab-width 4 indent-tabs-mode nil)
;; ... and detect the already existing indentation style.
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; haskell-mode specific indentation
(require 'ghc)
(require 'haskell-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(require 'company-ghc)
(add-to-list 'company-backends 'company-ghc)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(require 'highlight-symbol)
;; (global-set-key (kbd "C-b") 'highlight-symbol-at-point)
(setq highlight-symbol-idle-delay 0.5)
(add-hook 'prog-mode-hook #'highlight-symbol-mode)

(require 'uniquify) 
(setq
    uniquify-buffer-name-style 'post-forward
    uniquify-separator ":")

(require 'yasnippet)
(yas-global-mode 1)

;; Show matching parens (mixed style)
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)

;; Evil nerd-commenter
(evilnc-default-hotkeys)

;; Enable line numbers on the left.
(global-linum-mode t)

;; y/n vs yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Jump to the first error.
(global-set-key (kbd "M-g M-f") 'first-error)

(provide 'init)
;;; init.el ends here
