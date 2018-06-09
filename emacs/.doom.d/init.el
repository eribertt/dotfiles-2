;;;  -*- lexical-binding: t; -*-

(doom! :feature
       ;debugger
       eval
       (evil +everywhere)
       file-templates
       (lookup
        +devdocs)
       ;; +docsets)
       snippets
       spellcheck
       syntax-checker ;;+childframe)
       version-control
       workspaces

       :emacs
       dired
       ediff
       electric-indent
       ;eshell
       imenu
       term

       :completion
       (company
        +auto)

       ;the ultimate code completion backend
       (helm +fuzzy) ;+childframe)
       ;ido
       ;; (ivy) ;;+childframe)
       (lsp +sh)

       :ui
       doom
       ;doom-dashboard
       doom-modeline
       doom-quit
       evil-goggles
       hl-todo
       nav-flash
       ;tabbar

       vi-tilde-fringe
       window-select
       (popup
        +all
        +defaults)
       ;neotree
       treemacs

       :tools
       gist
       ;macos
       make
       magit             ;
       password-store
       pdf
       prodigy
       ;rgb
       rotate-text
       tmux
       upload
       editorconfig
       wakatime

       :lang
       assembly
       (cc +irony)
       crystal
       clojure
       csharp
       data
       elixir
       elm
       emacs-lisp
       ess
       go
       (haskell +intero)
       hy
       ;(java +meghanada)
       javascript
       julia
       latex
       ledger
       lua
       markdown
       nix
       ocaml
       (org
        +attach
        +babel
        +capture
        +export
        +present
        +publish)
       perl
       ;php
       plantuml
       purescript
       python
       rest
       ;ruby
       rust
       scala
       sh
       swift
       web

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       ;(email +gmail)
       irc
       ;(rss +org)
       twitter
       (write
        +wordnut
        +langtool)

       :editor
       parinfer

       :config
       ;; The default module set reasonable defaults for Emacs. It also provides
       ;; a Spacemacs-inspired keybinding scheme, a custom yasnippet library,
       ;; and additional ex commands for evil-mode. Use it as a reference for
       ;; your own modules.
       (default +bindings +snippets +evil-commands))

