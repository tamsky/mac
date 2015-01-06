; from https://github.com/stsquad/emacs_chrome/wiki/edit-server
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'edit-server)
(edit-server-start)

(require 'vc-hg)
(load-file "~/src/github/lisp/markdown-mode/markdown-mode.el")

(server-start)
