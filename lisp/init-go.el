;; (add-to-list 'load-path "neotree/")
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)

(require-package 'go-mode)
(require-package 'company-go)
(add-hook 'before-save-hook 'gofmt-before-save)

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")(require 'go-flymake)
(add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")(require 'go-flycheck)

(add-hook 'go-mode-hook 'company-mode)(add-hook 'go-mode-hook (lambda ()  (set (make-local-variable 'company-backends) '(company-go)) (company-mode)))

(add-hook 'go-mode-hook '(lambda ()
        (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

(add-hook 'go-mode-hook '(lambda ()
        (local-set-key (kbd "C-c C-g") 'go-goto-imports)))

(add-hook 'go-mode-hook '(lambda ()
        (local-set-key (kbd "C-c C-k") 'godoc)))

(provide 'init-go)
