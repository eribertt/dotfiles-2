;;; editor/lispyville/config.el -*- lexical-binding: t; -*-

(def-package! lispy
  :defer t
  :init
  (add-hook 'emacs-lisp-mode-hook #'lispy-mode))

;; TODO: set key themes https://github.com/noctuid/lispyville
(def-package!
  lispyville
  :after lispy
  :config (add-hook 'lispy-mode-hook #'lispyville-mode))
