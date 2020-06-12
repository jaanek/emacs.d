;;; init-java.el --- Support for Java -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

(provide 'init-java)
;;; init-java.el ends here
