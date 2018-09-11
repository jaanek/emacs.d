;;; package summary

;; editor keymaps
(global-set-key (kbd "C-c C-c") 'comment-line)
(global-set-key (kbd "C-c C-r") 'find-file-in-project)
(global-set-key (kbd "C-<left>") 'backward-word)
(global-set-key (kbd "C-<right>") 'forward-word)
(global-set-key (kbd "C-<down>") 'end-of-defun)
(global-set-key (kbd "C-<up>") 'beginning-of-defun)

;; toggle window split

(defun toggle-frame-split ()
  "If the frame is split vertically, split it horizontally or vice versa.
Assumes that the frame is only split into two."
  (interactive)
  (unless (= (length (window-list)) 2) (error "Can only toggle a frame split in two"))
  (let ((split-vertically-p (window-combined-p)))
    (delete-window)                     ; closes current window
    (if split-vertically-p
        (split-window-horizontally)
      (split-window-vertically)) ; gives us a split with the other window twice
    (switch-to-buffer nil))) ; restore the original window in this part of the frame
;; I don't use the default binding of 'C-x 5', so use toggle-frame-split instead
(global-set-key (kbd "C-x 5") 'toggle-frame-split)


;; https://www.emacswiki.org/emacs/WindowResize
(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)

;; kill buffers - https://www.emacswiki.org/emacs/KillingBuffers



;; text zooming

(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

(defun global-text-scale-adjust (inc) (interactive)
       (text-scale-set 1)
       (kill-local-variable 'text-scale-mode-amount)
       (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
       (global-text-scale-mode 1)
       )

(global-set-key (kbd "C-0")
                '(lambda () (interactive)
                   (global-text-scale-adjust (- text-scale-mode-amount))
                   (global-text-scale-mode -1)))
(global-set-key (kbd "C-=")
                '(lambda () (interactive) (global-text-scale-adjust 1)))
(global-set-key (kbd "C--")
                '(lambda () (interactive) (global-text-scale-adjust -1)))


(provide 'init-local)
