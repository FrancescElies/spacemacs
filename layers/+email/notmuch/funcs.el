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

(defun spacemacs/notmuch-show-close-all ()
  (interactive)
  (goto-char (point-min))
  (setq current-prefix-arg '(4))
  (call-interactively 'notmuch-show-open-or-close-all))



;;;;;;;;;
;; git ;;
;;;;;;;;;

(defun spacemacs/notmuch-git-apply-patch (entire-thread)
  "Apply patch from a notmuch-show email buffer to a git repository

If ENTIRE-THREAD is non-nil it will apply patches from all open
messages in the current thread"
  (interactive "P")
  (notmuch-show-pipe-message entire-thread "git am"))

(defun spacemacs/notmuch-git-apply-patch-part ()
  "Apply patch attached to a message as MIME part to a git repository."
  (interactive)
  (let ((mime-type nil))
    (notmuch-show-apply-to-current-part-handle (lambda ()
                                                 (mm-pipe-part (notmuch-show-current-part-handle mime-type) "git am")))))


