;; (add-to-list 'load-path "neotree/")
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)

(require-package 'go-mode)
(require-package 'company)
(require-package 'company-go) ;; autocomplete - https://github.com/mdempsky/gocode/tree/master/emacs-company

;; go-code setup
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)
;; (ac-config-default)

;;(require-package 'go-guru)
;;(require-package 'go-rename)

(add-hook 'before-save-hook 'gofmt-before-save)

;; (add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")(require 'go-flymake)
;; (add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")(require 'go-flycheck)

(add-hook 'go-mode-hook 'company-mode)(add-hook 'go-mode-hook (lambda ()  (set (make-local-variable 'company-backends) '(company-go)) (company-mode)))

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
  (local-set-key (kbd "M-.") 'godef-jump) ; Go to definition
  (local-set-key (kbd "C-c C-]") 'next-error) ; Go to next error (or msg)
  (local-set-key (kbd "C-c C-[") 'previous-error) ; Go to previous error or msg
  )

;; Connect go-mode-hook with the function we just defined
(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
