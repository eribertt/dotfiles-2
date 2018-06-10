;; -*- no-byte-compile: t; -*-
;;; completion/lsp/packages.el

(package! lsp-mode)
(package! lsp-ui)
(package! company-lsp)

(when (featurep! +javascript)
  ;; (package! lsp-javascript-typescript)
  (package! lsp-typescript
    :recipe (:fetcher github
                      :repo "emacs-lsp/lsp-javascript"
                      :files ("lsp-typescript.el")))
  (package! tide :disable t))

(when (featurep! +go)
  (package! lsp-go))

(when (featurep! +python)
  (package! anaconda-mode :disable t))

(when (featurep! +rust)
  (package! lsp-rust)
  (package! racer :disable t))
