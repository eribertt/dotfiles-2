;;; completion/lsp/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
  :commands (lsp-mode lsp-define-stdio-client))

(def-package! lsp-ui
  :commands (lsp-ui-mode)
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (set! :lookup 'lsp-ui-mode
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)
  (+peek-set-face-theme)
  (setq lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 35
        lsp-ui-sideline-ignore-duplicate t))
        ;; lsp-ui-doc-position 'at-point))

(def-package! lsp-javascript-typescript
  :commands (lsp-javascript-typescript-enable)
  :init
  (add-hook! (typescript-mode
              js2-mode)
    #'lsp-javascript-typescript-enable)
  :config
  (defun my-company-transformer (candidates)
    (let ((completion-ignore-case t))
      (all-completions (company-grab-symbol) candidates)))

  (add-hook! 'js2-mode-hook
    (make-local-variable 'company-transformers)
    (push 'my-company-transformer company-transformers)))

(def-package! lsp-typescript
  :commands (lsp-typescript-enable)
  :init
  (after! js2-mode
    (add-hook 'js2-mode-hook #'lsp-typescript-enable))
  (after! typescript-mode
    (add-hook 'typescript-mode-hook #'lsp-typescript-enable)))


(def-package! company-lsp
  :after lsp-mode
  :config
  (set! :company-backend 'lsp-mode '(company-lsp))
  (setq company-lsp-enable-recompletion t))

(def-package! lsp-go
  :when (featurep! +go)
  :commands (lsp-go-enable)
  :init
  (add-hook! go-mode #'lsp-go-enable))

(when (featurep! +python)
  (after! python
    (lsp-define-stdio-client lsp-python "python"
                             (lsp-make-traverser #'(lambda (dir)
                                                     (directory-files
                                                      dir
                                                      nil
                                                      "requirements\\.txt")))
                             '("pyls"))
    (add-hook! python-mode #'lsp-python-enable)))



(when (featurep! +sh)
  (after! sh-script
    (lsp-define-stdio-client lsp-sh
                            "sh"
                            #'(lambda () default-directory)
                            '("bash-language-server" "start"))
    (add-hook 'sh-mode-hook #'lsp-sh-enable)))

(defun +peek-set-face-theme ()
  ;; Stolen from https://github.com/syl20bnr/spacemacs/blob/develop/layers/%2Btools/lsp/funcs.el#L12
  (set-face-attribute 'lsp-ui-peek-list nil
                      :background (face-attribute 'hl-line :background nil t))
  (set-face-attribute 'lsp-ui-peek-peek nil
                      :background (face-attribute 'hl-line :background nil t))
  (set-face-attribute 'lsp-ui-peek-selection nil
                      :background (face-attribute 'highlight :background nil t)
                      :foreground (face-attribute 'default :foreground nil t))
  (set-face-attribute 'lsp-ui-peek-filename nil
                      :foreground (face-attribute 'font-lock-constant-face
                                                  :foreground nil t))
  (set-face-attribute 'lsp-ui-peek-highlight nil
                      :background (face-attribute 'highlight :background nil t)
                      :foreground (face-attribute 'highlight :foreground nil t)
                      :distant-foreground (face-attribute 'highlight
                                                          :foreground nil t))
  (set-face-attribute 'lsp-ui-peek-header nil
                      :background (face-attribute 'highlight :background nil t)
                      :foreground (face-attribute 'default :foreground nil t)))
