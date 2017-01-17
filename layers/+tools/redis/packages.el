;;; layers.el --- Redis layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst redis-packages
  '(redis
    ob-redis))


(defun redis/init-redis ()
  (use-package redis
    :defer t
    :init
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'redis-mode
        "'" 'redis-cli
        "c" 'redis-send-current-line
        "b" 'redis-send-buffer-content
        "r" 'redis-send-region-content
        "s" 'redis-switch-to-cli
        ))))

(defun redis/init-ob-redis ()
  (spacemacs|use-package-add-hook org
    :post-config
    (use-package ob-redis
      :init (add-to-list 'org-babel-load-languages '(redis . t)))))
