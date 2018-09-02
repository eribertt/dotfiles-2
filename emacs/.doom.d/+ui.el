;;;  -*- lexical-binding: t; -*-

;; Fonts
(setq doom-font (font-spec :family "Hack" :size 18))
;; On my (almost) 1440p monitor, 28pt Hack gives me about 30 lines and maybe
;; 100-120 columns, which seems like a good zoomed in size for eye
;; strain/showing other people stuff
(setq doom-big-font (font-spec :family "Hack" :size 28))

;; Dash highlighting
(after! dash (dash-enable-font-lock))

(load! "+magit")
