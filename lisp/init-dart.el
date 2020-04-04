;; https://github.com/bradyt/dart-mode
(require-package 'dart-mode)
(require-package 'lsp-mode)
;; (require-package 'lsp-ui)

(setq lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk/")
(setq dart-format-on-save t)

;; https://github.com/emacs-lsp/lsp-mode
;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; lsp
;; https://github.com/bradyt/dart-mode/wiki/LSP
(add-hook 'dart-mode-hook 'lsp)
(with-eval-after-load "projectile"
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))
(setq lsp-auto-guess-root t)

(provide 'init-dart)
