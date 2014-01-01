;; idonethis.el

;; Some methods that wrap the cli tool

(defgroup idonethis nil
  "idonethis"
  :group 'applications)

(defun idonethis-send (stuff)
  (interactive "sWhat have you done today?: ")
  (shell-command (format "idonethis '%s'&" stuff)))

(provide 'idonethis)
