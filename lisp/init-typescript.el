(require-package 'tide)

;; https://github.com/ananthakumaran/tide

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  ;; use 2 space indentation
  (setq typescript-indent-level 2)
  ;; see https://github.com/Microsoft/TypeScript/blob/cc58e2d7eb144f0b2ff89e6a6685fb4deaa24fde/src/server/protocol.d.ts#L421-473 for the full list available options
  ;; https://github.com/ananthakumaran/tide/issues/164
  (setq tide-format-options '(:indentSize 2 :tabSize 2 :convertTabsToSpaces t :insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces :json-false))
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; tsx
;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))
;; ;; enable typescript-tslint checker
;; (flycheck-add-mode 'typescript-tslint 'web-mode)

(provide 'init-typescript)
