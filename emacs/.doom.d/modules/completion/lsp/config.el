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

(def-package! lsp-css
  :when (featurep! +css)
  :commands (lsp-css-enable)
  :init
  (add-hook! (css-mode
              less-mode
              ;; sass-mode ; rip :(
              scss-mode)
    #'lsp-css-enable))

(def-package! lsp-rust
  :when (featurep! +rust)
  :commands (lsp-rust-enable)
  :init
  (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls"))
  (after! rust-mode
    (add-hook 'rust-mode-hook #'lsp-rust-enable)))

(def-package! cquery
  :when (featurep! +cpp)
  :commands (lsp-cquery-enable)
  :init
  (setq cquery-extra-init-params '(:index (:comments 2)
                                          :cacheFormat "msgpack"
                                          :completion (:detailedLabel t))
        cquery-sem-highlight-method 'overlay) ;; set to 'font-lock if highlighting slowly
  (defun +setup-cquery ()
    (setq-local company-transformers nil)
    (setq company-lsp-cache-candidates nil)
    (condition-case nil
        (lsp-cquery-enable)
      (user-error nil)))
  (add-hook! 'c-mode-common-hook #'+setup-cquery))


(when (featurep! +python)
  (after! python
    (lsp-define-stdio-client lsp-python "python"
                             #'projectile-project-root
                             '("pyls"))
    (add-hook! python-mode #'lsp-python-enable)))

(when (featurep! +sh)
  (after! sh-script
    (lsp-define-stdio-client lsp-sh
                            "sh"
                            #'projectile-project-root
                            '("bash-language-server" "start"))
    (add-hook 'sh-mode-hook #'lsp-sh-enable)))

