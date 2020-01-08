;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)

(when (maybe-require-package 'anaconda-mode)
  (after-load 'python
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
  (after-load 'anaconda-mode
    (define-key anaconda-mode-map (kbd "M-?") nil))
  (when (maybe-require-package 'company-anaconda)
    (after-load 'company
      (after-load 'python
        (push 'company-anaconda company-backends)))))

;; conda mode
(require 'conda)
(custom-set-variables
 '(conda-anaconda-home "/opt/miniconda3"))

;; conda mode
;;(use-package conda
;;  :ensure t
;;  :init
;;  (setq conda-anaconda-home (expand-file-name "/opt/miniconda3"))
;;  (setq conda-env-home-directory (expand-file-name "/opt/miniconda3"))
;;  )

(provide 'init-python)
;;; init-python.el ends here
