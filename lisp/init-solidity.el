;;; package --- Solidity mode
;;; Commentary:
;;; Code:

(require-package 'solidity-mode)

;; https://github.com/ethereum/emacs-solidity
;; Configuring solc checker
(setq solidity-solc-path "/usr/bin/solc")
(setq solidity-flycheck-solc-checker-active t)
;; (setq flycheck-solidity-solc-addstd-contracts t)
;; Configuring solium checker
(setq solidity-solium-path "solium")
(setq solidity-flycheck-solium-checker-active t)
;; Using .dir-locals.el file on project level to set the soliumrc file path
;; (setq flycheck-solidity-solium-soliumrcfile "/home/jaanek/.soliumrc.json")

;; https://emacs.stackexchange.com/a/17565/12560
(defun solidity-custom-settings ()
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (local-set-key (kbd "C-c C-l") 'find-file-in-project))

(add-hook 'solidity-mode-hook 'solidity-custom-settings)

(add-hook 'solidity-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '((company-solidity company-capf company-dabbrev-code))
                         company-backends))))

(provide 'init-solidity)

;;; init-solidity.el ends here
