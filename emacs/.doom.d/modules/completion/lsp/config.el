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
                      :foreground (face-attribute 'default :foreground nil t))
  (setq lsp-ui-doc-enable nil)) ;; This is so intrusive

(when (featurep! +sh)
  (lsp-define-stdio-client lsp-sh
                          "sh"
                          #'(lambda () default-directory)
                          '("bash-language-server" "start"))
  (add-hook 'sh-mode-hook #'lsp-sh-enable))
