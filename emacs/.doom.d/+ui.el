;;;  -*- lexical-binding: t; -*-

;; Fonts
(setq doom-font (font-spec :family "Hack" :size 18))
(setq doom-big-font (font-spec :family "Hack" :size 25))

;; Dash highlighting
(after! dash (dash-enable-font-lock))

(load! "+magit")
