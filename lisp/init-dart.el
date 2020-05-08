;; https://emacs-lsp.github.io/lsp-dart/
(use-package lsp-mode :ensure t)

(use-package lsp-dart 
  :ensure t 
  :hook (dart-mode . lsp))

;; Optional packages
(use-package lsp-ui :ensure t)
;;(use-package company-capf :ensure t)

(setq lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk/")
;; (setq dart-format-on-save t)

;; Slows down, disable it
(setq lsp-dart-flutter-widget-guides nil)
(setq lsp-dart-show-flutter-outline nil)
(setq lsp-dart-show-outline nil)
;;(setq lsp-dart-closing-labels t)

;; Configure projectile to find the package pubspec.yaml and set the folder as project root
(with-eval-after-load "projectile"
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))
(setq lsp-auto-guess-root t)

(provide 'init-dart)
