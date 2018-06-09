;; -*- no-byte-compile: t; -*-
;;; completion/lsp/packages.el

(package! lsp-mode)
(package! lsp-ui)
(package! company-lsp)

(when (featurep! +javascript)
  (package! lsp-javascript-typescript)
  (package! tide :disable t))

(when (featurep! +go)
  (package! lsp-go))
