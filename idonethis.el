;; idonethis.el

;; Some methods that wrap the cli tool

(defgroup idonethis nil
  "idonethis"
  :group 'applications)

(defconst cookie-header "Cookie: sessionid=hbq8qeymypwy6amhiierfhcianbdbq6t;")
(defconst base-idonethis-url "https://idonethis.com/api/v3/team/banno-grip/dones/?start=%s&end=%s")
(defconst base-command-string "curl '%s' -H '%s' --compressed | json -a owner done_date markedup_text | sort | sed 's/$/\\n\\n/g'")

;;;###autoload
(defun idonethis-send (stuff)
  (interactive "sWhat have you done today?: ")
  (shell-command (format "idonethis \"%s\"&" (shell-quote-argument stuff))))

;;;###autoload
(defun idonethis-dones (&optional maybe-start-date &optional maybe-end-date)
  (interactive)
  (let* ((start-date (if maybe-start-date
                         maybe-start-date
                       (format-time-string "%Y-%m-%d")))
        (end-date (if maybe-end-date
                      maybe-end-date
                    (format-time-string "%Y-%m-%d")))
        (url (format base-idonethis-url start-date end-date))
        (command (format base-command-string url cookie-header))
        (command-res (shell-command-to-string (concat command "&")))
        (idonethis-buffer (find-file (concat "*idonethis-done-" start-date "-to-" end-date "*"))))
    (switch-to-buffer idonethis-buffer nil t)
    (erase-buffer)
    (insert command-res)
    (save-buffer)
    (delete-other-windows)
    (goto-line 4)))

(provide 'idonethis)
