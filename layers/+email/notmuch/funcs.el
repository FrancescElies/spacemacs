(defun spacemacs/notmuch-message-delete (go-next)
  (interactive)
  (notmuch-search-tag '("+deleted" "-inbox" "-unread"))

  (if (equal go-next "up")
      (notmuch-search-previous-thread)
    (notmuch-search-next-thread)))
(defun spacemacs/notmuch-message-delete-down ()
  (interactive)
  (spacemacs/notmuch-message-delete "down"))

(defun spacemacs/notmuch-message-delete-up ()
  (interactive)
  (spacemacs/notmuch-message-delete "up"))

(defun spacemacs/notmuch-trash (&optional beg end)
  "trash by removing inbox and adding trash"
  (interactive (notmuch-search-interactive-region))
  (notmuch-search-tag (list "-inbox" "+trash")
                      beg
                      end)
  (when (eq beg end)
    (notmuch-search-next-thread)))

(defun spacemacs/notmuch-trash-show ()
  "trash shown msg by removing inbox and adding trash"
  (interactive)
  (notmuch-show-add-tag (list "-inbox" "+trash"))
  (unless (notmuch-show-next-open-message)
    (defun spacemacs/compose-mail-other-frame ()
      "create a new frame for the mail composition"
      (compose-mail-other-frame))
    (notmuch-show-next-thread t)))
