;;; packages.el --- mu4e Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq notmuch-packages '(notmuch helm-notmuch))

(defun notmuch/init-notmuch ()
  (use-package notmuch
    :defer t
    :commands notmuch
    :init
    (progn
      (spacemacs/set-leader-keys "aN" 'notmuch)
      (load-library "org-notmuch")


      (dolist (prefix '(("ms" . "stash")
                        ("mp" . "part")))
        (spacemacs/declare-prefix-for-mode 'notmuch-show-mode (car prefix) (cdr prefix)))

      (spacemacs/set-leader-keys-for-major-mode 'notmuch-show-mode
        ;; part
        ;; "p?" 'notmuch-subkeymap-help
        "pm" 'notmuch-show-choose-mime-of-part
        "p|" 'notmuch-show-pipe-part
        "po" 'notmuch-show-interactively-view-part
        "pv" 'notmuch-show-view-part
        "ps" 'notmuch-show-save-part
        ;; stash
        ;; "s?" 'notmuch-subkeymap-help
        "sG" 'notmuch-show-stash-git-send-email
        "sL" 'notmuch-show-stash-mlarchive-link-and-go
        "sl" 'notmuch-show-stash-mlarchive-link
        "st" 'notmuch-show-stash-to
        "sT" 'notmuch-show-stash-tags
        "ss" 'notmuch-show-stash-subject
        "sI" 'notmuch-show-stash-message-id-stripped
        "si" 'notmuch-show-stash-message-id
        "sf" 'notmuch-show-stash-from
        "sF" 'notmuch-show-stash-filename
        "sd" 'notmuch-show-stash-date
        "sc" 'notmuch-show-stash-cc
        )

     (evilified-state-evilify notmuch-hello-mode notmuch-hello-mode-map
       (kbd "J") 'notmuch-jump-search
       )
     (evilified-state-evilify notmuch-show-mode notmuch-show-mode-map
       (kbd "J") 'notmuch-jump-search
       (kbd "N") 'notmuch-show-next-message
       (kbd "n") 'notmuch-show-next-open-message
       (kbd "T") 'spacemacs/notmuch-trash-show)

     (evilified-state-evilify notmuch-tree-mode notmuch-tree-mode-map)
     (evilified-state-evilify notmuch-search-mode notmuch-search-mode-map
                                        ;TODO: [[file:~/dotfiles/spacemacs/load-conf-files/notmuch.el][file:~/dotfiles/spacemacs/load-conf-files/notmuch.el]]
       (kbd "a") 'spacemacs/notmuch-message-archive
       (kbd "d") 'spacemacs/notmuch-message-delete-down
       (kbd "D") 'spacemacs/notmuch-message-delete-up
       (kbd "J") 'notmuch-jump-search
       (kbd "L") 'notmuch-search-filter
       (kbd "gg") 'notmuch-search-first-thread
       (kbd "G") 'notmuch-search-last-thread
       (kbd "T") 'spacemacs/notmuch-trash
       (kbd "M") 'compose-mail-other-frame)

     (evil-define-key 'normal notmuch-search-mode-map
       "F" 'spacemacs/notmuch-remove-inbox-tag)

     (evil-define-key 'visual notmuch-search-mode-map
              "*" 'notmuch-search-tag-all
              "a" 'notmuch-search-archive-thread
              "-" 'notmuch-search-remove-tag
              "+" 'notmuch-search-add-tag
              "F" '(lambda (&optional beg end)
                    "archive by removing inbox tag"
                    (interactive (notmuch-search-interactive-region))
                    (notmuch-search-tag (list "+archive" "-inbox") beg end)))

    ;; TODO: add to my custom
    ;; (setq notmuch-address-command "~/bin/nottoomuch-addresses.sh")
    ;; (setq sendmail-program "~/bin/msmtp-enqueue.sh")
    ;; (setq message-sendmail-extra-arguments '("-a" "Basho"))
    ;; (setq mail-host-address "@basho.com")
    ;; (setq user-full-name "Torben Hoffmann")
    ;; (setq user-mail-address "thoffmann@basho.com")
    (setq message-sendmail-f-is-evil 't)))


  ;; from https://github.com/fgeller/emacs.d/blob/master/email.org
  (add-hook 'notmuch-show-hook 'spacemacs/notmuch-show-prefer-html-over-text)


  ;; fixes: killing a notmuch buffer does not show the previous buffer
  (push "\\*notmuch.+\\*" spacemacs-useful-buffers-regexp)
  )

(defun notmuch/init-helm-notmuch ()
  (use-package helm-notmuch
    :defer t
    :init (with-eval-after-load 'notmuch)))
