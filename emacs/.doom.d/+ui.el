;;;  -*- lexical-binding: t; -*-

;; Fonts
(setq doom-font (font-spec :family "Iosevka" :size 21))
(setq doom-big-font (font-spec :family "Iosevka" :size 25))

;; Dash highlighting
(after! dash (dash-enable-font-lock))

;; Show evil-motion before the word instead of over it
(setq avy-style 'pre)

;; Change theme.
;; Nord is pretty cool: https://github.com/arcticicestudio/nord
;; A nice alternative (although brighter) could be: nova - https://trevordmiller.com/projects/nova
(setq doom-theme 'doom-nord)
(setq +doom-modeline-buffer-file-name-style 'relative-from-project)

(setq +pretty-code-iosevka-ligatures-enabled-by-default t) ;; I use Iosevka!

;; Thanks to bitwalker for this
(after! neotree
  ;; When switching to a file in the current project, expand the directory
  ;; tree to the new file buffer
  (add-hook! 'find-file-hook
    (if (and (buffer-file-name) (neo-global--window-exists-p))
        ;; And only if the file is a child of the current neotree root
        (if (neo-global--file-in-root-p (buffer-file-name))
            ;; We need to trigger neotree-find then switch back to the buffer we just opened
            (save-current-buffer (neotree-find))))))

(load! "+magit")
