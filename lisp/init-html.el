;;; init-html.el --- Editing HTML -*- lexical-binding: t -*-
;;; Commentary:

;; ERB is configured separately in init-ruby

;;; Code:

(require-package 'tagedit)
(with-eval-after-load 'sgml-mode
  (tagedit-add-paredit-like-keybindings)
  (define-key tagedit-mode-map (kbd "M-?") nil)
  (define-key tagedit-mode-map (kbd "C-<right>") nil)
  (define-key tagedit-mode-map (kbd "C-<left>") nil)
  (add-hook 'sgml-mode-hook (lambda ()
                              (tagedit-mode 1)
                              (local-set-key (kbd "C-c C-i") 'indent-region)
                              )))

(add-auto-mode 'html-mode "\\.\\(jsp\\|tmpl\\)\\'")


(provide 'init-html)
;;; init-html.el ends here
