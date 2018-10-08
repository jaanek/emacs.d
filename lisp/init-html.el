(require-package 'tagedit)
(after-load 'sgml-mode
  ;; https://github.com/magnars/tagedit
  (tagedit-add-paredit-like-keybindings)
  (define-key tagedit-mode-map (kbd "M-?") nil)
  (define-key tagedit-mode-map (kbd "C-<right>") nil)
  (define-key tagedit-mode-map (kbd "C-<left>") nil)
  (add-hook 'sgml-mode-hook (lambda ()
                              (tagedit-mode 1)
                              (local-set-key (kbd "C-c C-i") 'indent-region)
                              )))

(add-auto-mode 'html-mode "\\.\\(jsp\\|tmpl\\)\\'")

;; Note: ERB is configured in init-ruby

(provide 'init-html)
