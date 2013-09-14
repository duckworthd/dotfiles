; load snippets
(yas/load-directory "~/.emacs.d/el-get/yasnippet/snippets")

; enable yasnippet in lots of modes
(defun enable-yas()
  (yas/minor-mode t))

(add-hook 'c-mode-hook 'enable-yas)
(add-hook 'c++-mode-hook 'enable-yas)
(add-hook 'html-mode-hook 'enable-yas)
(add-hook 'latex-mode-hook 'enable-yas)
(add-hook 'markdown-mode-hook 'enable-yas)
(add-hook 'python-mode-hook 'enable-yas)
(add-hook 'rst-mode-hook 'enable-yas)
(add-hook 'ruby-mode-hook 'enable-yas)
(add-hook 'scala-mode-hook 'enable-yas)
