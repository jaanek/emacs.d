;; https://github.com/bradyt/dart-mode
(require-package 'dart-mode)
(require-package 'lsp-mode)
;; (require-package 'lsp-ui)

;; (setq dart-enable-analysis-server t)
(setq dart-format-on-save t)
;; (defcustom lsp-dart-sdk-dir "~/flutter/bin/cache/dart-sdk/" by default in lsp-mode
(setq lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk/")

;; https://github.com/emacs-lsp/lsp-mode
;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)
;; (add-hook 'dart-mode-hook #'lsp)
(add-hook 'dart-mode-hook 'flycheck-mode)

(provide 'init-dart)
