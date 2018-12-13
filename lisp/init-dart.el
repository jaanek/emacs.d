(require-package 'dart-mode)
;; https://github.com/bradyt/dart-mode

(setq dart-enable-analysis-server t)
(setq dart-format-on-save t)

(add-hook 'dart-mode-hook 'flycheck-mode)

(provide 'init-dart)
