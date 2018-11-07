;; http://web-mode.org/
(require-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.nunj\\'" . web-mode))
(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("django"  . "\\.nunj\\'")) ;; http://web-mode.org/#engines
      )
(provide 'init-web)
