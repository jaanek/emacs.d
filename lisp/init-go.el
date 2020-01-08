;; (add-to-list 'load-path "neotree/")
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)

(require-package 'go-mode)

;; company autocomplete with gocode - https://github.com/mdempsky/gocode/tree/master/emacs-company
;; (require-package 'company)
;; (require-package 'company-go)
;; (add-hook 'go-mode-hook 'company-mode)(add-hook 'go-mode-hook (lambda ()  (set (make-local-variable 'company-backends) '(company-go)) (company-mode)))

;; Use gopls - Go Language Server Protocol - autocomplete, go to definition
;; Example confiuration - https://ladicle.com/post/config/#lsp
(require-package 'lsp-mode)
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-prefer-flymake nil ;; Prefer using lsp-ui (flycheck) over flymake.
        lsp-enable-snippet nil ;; if you are using completion-at-point the snippets won’t be expanded and you should either disable them by setting lsp-enable-snippet to nil or you should switch to company-lsp
        )
  )
(add-hook 'go-mode-hook #'lsp-deferred)

;; optional - provides fancier overlays
(require-package 'lsp-ui)
(use-package lsp-ui
  :requires lsp-mode flycheck
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25)

  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  )

;; gocode autocomplete setup - https://github.com/stamblerre/gocode
;; (require-package 'auto-complete)
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)
;; (ac-config-default)

;;(require-package 'go-guru)
;;(require-package 'go-rename)

;; goimports - https://godoc.org/golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; (add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")(require 'go-flymake)
;; (add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")(require 'go-flycheck)

(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-g") 'go-goto-imports)))

(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-k") 'godoc)))


;; Define function to call when go-mode loads
;; https://johnsogg.github.io/emacs-golang
(defun my-go-mode-hook ()
  ;; Key bindings specific to go-mode
  ;; (local-set-key (kbd "M-.") 'godef-jump) ; Go to definition
  (local-set-key (kbd "C-c C-]") 'next-error) ; Go to next error (or msg)
  (local-set-key (kbd "C-c C-[") 'previous-error) ; Go to previous error or msg
  )

;; Connect go-mode-hook with the function we just defined
(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
