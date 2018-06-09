;;;  -*- lexical-binding: t; -*-

(def-package! parinfer
  :commands (parinfer-mode)
  :init
  (defun +disable-yas ()
    "Disable yasnippet so parinfer works."
    (yas-minor-mode -1)
    (parinfer-mode))

  (add-hook! (emacs-lisp-mode
              clojure-mode
              common-lisp-mode
              scheme-mode
              lisp-mode)
    #'+disable-yas)
  (setq parinfer-extensions
        '(defaults
           evil
           pretty-parens
           smart-tab
           smart-yank))
  :config
  (map! :map emacs-lisp-mode-map
        :i "<tab>" #'parinfer-smart-tab:dwim-right
        :i "<backtab>" #'parinfer-smart-tab:dwim-left)
  ;; FIXME Parinfer isn't being mapped
  (map! :map parinfer-mode-map
        :localleader
        :nv "m" #'parinfer-toggle-mode))

