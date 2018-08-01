;;;  -*- lexical-binding: t; -*-

;; Fonts
(setq doom-font (font-spec :family "Iosevka" :size 18))
(setq doom-big-font (font-spec :family "Iosevka" :size 25))

;; Dash highlighting
(after! dash (dash-enable-font-lock))

(load! "+magit")
