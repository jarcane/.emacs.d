;;; Annie's emacs

;; secure packages
;; see: https://glyph.twistedmatrix.com/2015/11/editor-malware.html

(require 'package)

(setq package-archives `(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(setq tls-checktrust t)

(let ((trustfile
       (replace-regexp-in-string
        "\\\\" "/"
        (replace-regexp-in-string
         "\n" ""
         (shell-command-to-string "python -m certifi")))))
  (setq tls-program
        (list
         (format "gnutls-cli%s --x509cafile %s -p %%p %%h"
                 (if (eq window-system 'w32) ".exe" "") trustfile)))
  (setq gnutls-verify-error t)
  (setq gnutls-trustfiles (list trustfile)))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; setup basic stuff
;; Suggestions based on: https://www.masteringemacs.org/article/beginners-guide-to-emacs
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

(define-key global-map (kbd "RET") 'newline-and-indent)

;; Customization

(load-theme 'tango-dark)
(desktop-save-mode 1)

(use-package all-the-icons
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (treemacs-resize-icons 20)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))

  :bind
  (:map global-map
	("M-0"       . treemacs-select-window)
	("C-x t 1"   . treemacs-delete-other-windows)
	("C-x t t"   . treemacs)
	("C-x t B"   . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))
(treemacs)

(use-package tabbar
  :ensure t)

; https://github.com/manateelazycat/awesome-tab
(use-package awesome-tab
  :load-path "~/.emacs.d/awesome-tab"
  :config (progn
	    (awesome-tab-mode t)
	    (setq awesome-tab-height 100)
	    (setq awesome-tab-label-fixed-length 14)))

;; (use-package rainbow-delimiters
;;   :ensure t
;;   :hook prog-mode)

(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode))

;; Clojure/Racket stuff
(use-package cider
  :ensure t)

(use-package smartparens
  :ensure t)

(require 'smartparens-config)
(add-hook 'prog-mode-hook #'smartparens-mode)
(add-hook 'clojure-mode-hook #'smartparens-mode)
(add-hook 'cider-repl-mode-hook #'smartparens-mode)

(use-package company
  :ensure t)
(global-company-mode)
(add-hook 'clojure-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

;; Automatic stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (undo-tree company company-mode all-the-icons rainbow-delimiters tabbar treemacs use-package smartparens fish-mode cider)))
 '(safe-local-variable-values
   (quote
    ((cider-cljs-repl-types
      (edge "(do (require 'dev-extras) ((resolve 'dev-extras/cljs-repl)))"))
     (cider-default-cljs-repl . edge)
     (cider-clojure-cli-global-options . "-A:dev:build:dev/build")
     (cider-repl-init-code "(dev)")
     (cider-ns-refresh-after-fn . "dev-extras/resume")
     (cider-ns-refresh-before-fn . "dev-extras/suspend")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 98 :width normal)))))
