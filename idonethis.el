;; idonethis.el

;; Some methods that wrap the cli tool

(defun idonethis-send (stuff)
  (interactive "sWhat have you done today?: ")
  (shell-command (format "idonethis '%s'" stuff)))
