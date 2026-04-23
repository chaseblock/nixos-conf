;; Speeds up startup times, changes reverted after startup is complete
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
;; IDK what this does tbh, but seems to help startup times a bit
      file-name-handler-alist-original file-name-handler-alist
      file-name-handler-alist nil
      frame-inhibit-implied-resize t)
;; disable package.el at early init
;; even though it will be loaded later
;; shaves off some startup time
(setq package-enable-at-startup nil ; don't auto-initialize!
      ;; don't add that `custom-set-variables' block to my init.el!
      package--init-file-ensured t)
;; Fix some weird font behaviors?
(defun cb/set-font-faces ()
  (message "Setting faces!")
  (set-face-attribute 'default nil :font "FantasqueSansM Nerd Font" :height 10)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil :font "FantasqueSansM" :height 10)

  ;; Set the variable pitch face
  ;; TODO: figure out what I want to do for the variable-width
  ;; (set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)
)

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                ;; (setq doom-modeline-icon t)
                (with-selected-frame frame
                  (cb/set-font-faces))))
    (cb/set-font-faces))
