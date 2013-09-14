((auto-com status "removed" recipe nil)
 (auto-complete status "installed" recipe
                (:name auto-complete :website "http://cx4a.org/software/auto-complete/" :description "The most intelligent auto-completion extension." :type github :pkgname "m2ym/auto-complete" :depends
                       (popup fuzzy)))
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (ensime status "installed" recipe
         (:name ensime :description "ENhanced Scala Interaction Mode for Emacs" :type github :pkgname "aemoncannon/ensime" :build
                ("sbt update stage")
                :depends scala-mode :features ensime :load-path
                ("./src/main/elisp")
                :post-init
                (progn
                  (require 'ensime)
                  (require 'scala-mode-auto)
                  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))))
 (fuzzy status "installed" recipe
        (:name fuzzy :website "https://github.com/m2ym/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "m2ym/fuzzy-el"))
 (popup status "installed" recipe
        (:name popup :website "https://github.com/m2ym/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :pkgname "m2ym/popup-el"))
 (pymacs status "removed" recipe nil)
 (python-mode status "installed" recipe
              (:type github :username "emacsmirror" :name python-mode :type emacsmirror :description "Major mode for editing Python programs" :features
                     (python-mode doctest-mode)
                     :compile nil :load "test/doctest-mode.el" :prepare
                     (progn
                       (autoload 'python-mode "python-mode" "Python editing mode." t)
                       (add-to-list 'auto-mode-alist
                                    '("\\.py$" . python-mode))
                       (add-to-list 'interpreter-mode-alist
                                    '("python" . python-mode)))))
 (scala-mode status "installed" recipe
             (:name scala-mode :description "Major mode for editing Scala code." :type svn :url "http://lampsvn.epfl.ch/svn-repos/scala/scala-tool-support/trunk/src/emacs/" :build
                    ("make")
                    :load-path
                    (".")
                    :features scala-mode-auto))
 (yasnippet status "removed" recipe nil))
