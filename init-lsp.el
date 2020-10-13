;; (add-to-list 'load-path "neotree/")
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)

(require-package 'lsp-mode)
(require-package 'go-mode)
(require-package 'typescript-mode)

(use-package hydra)
(use-package helm)

(use-package helm-lsp
  :config
  (defun netrom/helm-lsp-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-workspace-symbol)))

  (defun netrom/helm-lsp-global-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-global-workspace-symbol))))

;; https://www.mortens.dev/blog/emacs-and-the-language-server-protocol/
(use-package lsp-mode
  :requires hydra helm helm-lsp
  :commands (lsp lsp-deferred)
  :hook ((
          ;; lsp-completion-mode           ; enable lsp completion
          c-mode                        ; clangd
          c-or-c++-mode                 ; clangd
          java-mode                     ; eclipse-jdtls
          js-mode                       ; ts-ls (tsserver wrapper)
          js-jsx-mode                   ; ts-ls (tsserver wrapper)
          typescript-mode               ; ts-ls (tsserver wrapper)
          python-mode                   ; mspyls
          web-mode
          css-mode                      ; css-ls - pure css
          scss-mode                     ; css-ls - sass
          yaml-mode
          ) . lsp)
  :config
  (setq lsp-prefer-flymake nil) ;; Prefer using lsp-ui (flycheck) over flymake.
  (setq lsp-auto-guess-root t)
  ;; (setq lsp-diagnostic-package :none)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-enable-folding nil)
  ;; (setq lsp-enable-snippet nil) ;; if you are using completion-at-point the snippets won’t be expanded and you should either disable them by setting lsp-enable-snippet to nil or you should switch to company-lsp
  ;; (setq lsp-enable-completion-at-point nil)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.5)
  (setq lsp-prefer-capf t)
  ;; (setq lsp-log-io  t)
  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascriptreact"))
  ;; (setq lsp-completion-styles '(helm-flex))
  (setq netrom--general-lsp-hydra-heads
        '(;; Xref
          ("d" xref-find-definitions "Definitions" :column "Xref")
          ("D" xref-find-definitions-other-window "-> other win")
          ("r" xref-find-references "References")
          ("s" netrom/helm-lsp-workspace-symbol-at-point "Helm search")
          ("S" netrom/helm-lsp-global-workspace-symbol-at-point "Helm global search")

          ;; Peek
          ("C-d" lsp-ui-peek-find-definitions "Definitions" :column "Peek")
          ("C-r" lsp-ui-peek-find-references "References")
          ("C-i" lsp-ui-peek-find-implementation "Implementation")

          ;; LSP
          ("p" lsp-describe-thing-at-point "Describe at point" :column "LSP")
          ("C-a" lsp-execute-code-action "Execute code action")
          ("R" lsp-rename "Rename")
          ("t" lsp-goto-type-definition "Type definition")
          ("i" lsp-goto-implementation "Implementation")
          ("f" helm-imenu "Filter funcs/classes (Helm)")
          ("C-c" lsp-describe-session "Describe session")

          ;; Flycheck
          ("l" lsp-ui-flycheck-list "List errs/warns/notes" :column "Flycheck"))

        netrom--misc-lsp-hydra-heads
        '(;; Misc
          ("q" nil "Cancel" :column "Misc")
          ("b" pop-tag-mark "Back")))
  )
(add-hook 'go-mode-hook #'lsp-deferred)
;; Create general hydra.
(eval `(defhydra netrom/lsp-hydra (:color blue :hint nil)
         ,@(append
            netrom--general-lsp-hydra-heads
            netrom--misc-lsp-hydra-heads)))
(add-hook 'lsp-mode-hook
          (lambda () (local-set-key (kbd "C-c C-l") 'netrom/lsp-hydra/body)))

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
        lsp-ui-peek-list-width 80
        lsp-ui-peek-peek-height 45
        lsp-ui-peek-fontify 'always
        )

  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  )

;; goimports - https://godoc.org/golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")

;; Define function to call when go-mode loads
;; https://johnsogg.github.io/emacs-golang
(defun my-go-mode-hook ()
  ;; (local-set-key (kbd "M-.") 'godef-jump) ; Go to definition
  (local-set-key (kbd "C-c C-]") 'next-error) ; Go to next error (or msg)
  (local-set-key (kbd "C-c C-[") 'previous-error) ; Go to previous error or msg
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (local-set-key (kbd "C-c C-g") 'go-goto-imports)
  (local-set-key (kbd "C-c C-k") 'godoc)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'before-save-hook 'gofmt-before-save)

;; typescript keybindings
(defun my-ts-mode-hook ()
  (setq-default typescript-indent-level 2)
  (add-hook 'before-save-hook (function lsp-format-buffer) t t)
  (add-hook 'before-save-hook (function lsp-organize-imports) t t)
  )
(add-hook 'typescript-mode-hook 'my-ts-mode-hook)

;; angular
(setq lsp-clients-angular-language-server-command
      '("node"
        "/home/jaanek/.nvm/versions/node/v12.18.3/lib/node_modules/@angular/language-server"
        "--ngProbeLocations"
        "/home/jaanek/.nvm/versions/node/v12.18.3/lib/node_modules"
        "--tsProbeLocations"
        "/home/jaanek/.nvm/versions/node/v12.18.3/lib/node_modules"
        "--stdio"))

;; https://emacs-lsp.github.io/lsp-ui/
;;(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
;;(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

(provide 'init-lsp)
