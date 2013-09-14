;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (el-get-checksum el-get-make-recipes el-get-cd
;;;;;;  el-get-self-update el-get-update-all el-get-version) "el-get/el-get"
;;;;;;  "el-get/el-get.el" (20632 37124))
;;; Generated autoloads from el-get/el-get.el

(autoload 'el-get-version "el-get/el-get" "\
Message the current el-get version

\(fn)" t nil)

(autoload 'el-get-update-all "el-get/el-get" "\
Performs update of all installed packages.

\(fn &optional NO-PROMPT)" t nil)

(autoload 'el-get-self-update "el-get/el-get" "\
Update el-get itself.  The standard recipe takes care of reloading the code.

\(fn)" t nil)

(autoload 'el-get-cd "el-get/el-get" "\
Open dired in the package directory.

\(fn PACKAGE)" t nil)

(autoload 'el-get-make-recipes "el-get/el-get" "\
Loop over `el-get-sources' and write a recipe file for each
entry which is not a symbol and is not already a known recipe.

\(fn &optional DIR)" t nil)

(autoload 'el-get-checksum "el-get/el-get" "\
Compute the checksum of the given package, and put it in the kill-ring

\(fn PACKAGE &optional PACKAGE-STATUS-ALIST)" t nil)

;;;***

;;;### (autoloads (el-get-list-packages) "el-get/el-get-list-packages"
;;;;;;  "el-get/el-get-list-packages.el" (20632 37124))
;;; Generated autoloads from el-get/el-get-list-packages.el

(autoload 'el-get-list-packages "el-get/el-get-list-packages" "\
Display a list of packages.

\(fn)" t nil)

;;;***

;;;### (autoloads (scala-mode) "scala-mode/scala-mode" "scala-mode/scala-mode.el"
;;;;;;  (20632 37443))
;;; Generated autoloads from scala-mode/scala-mode.el

(autoload 'scala-mode "scala-mode/scala-mode" "\
Major mode for editing Scala code.
When started, run `scala-mode-hook'.
\\{scala-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads (scala-quit-interpreter scala-load-file scala-eval-buffer
;;;;;;  scala-eval-definition scala-eval-region scala-switch-to-interpreter
;;;;;;  scala-run-scala scala-interpreter-running-p-1) "scala-mode/scala-mode-inf"
;;;;;;  "scala-mode/scala-mode-inf.el" (20632 37443))
;;; Generated autoloads from scala-mode/scala-mode-inf.el

(autoload 'scala-interpreter-running-p-1 "scala-mode/scala-mode-inf" "\


\(fn)" nil nil)

(autoload 'scala-run-scala "scala-mode/scala-mode-inf" "\
Run a Scala interpreter in an Emacs buffer

\(fn CMD-LINE)" t nil)

(autoload 'scala-switch-to-interpreter "scala-mode/scala-mode-inf" "\
Switch to buffer containing the interpreter

\(fn)" t nil)

(autoload 'scala-eval-region "scala-mode/scala-mode-inf" "\
Send current region to Scala interpreter.

\(fn START END)" t nil)

(autoload 'scala-eval-definition "scala-mode/scala-mode-inf" "\
Send the current 'definition' to the Scala interpreter.
This function's idea of a definition is the block of text ending
in the current line (or the first non-empty line going
backwards), and begins in the first line that is not empty and
does not start with whitespace or '{'.

For example:

println( \"aja\")
println( \"hola\" )

if the cursor is somewhere in the second print statement, the
interpreter should output 'hola'.

In the following case, if the cursor is in the second line, then
the complete function definition will be send to the interpreter:

def foo =
  1 + 2

\(fn)" t nil)

(autoload 'scala-eval-buffer "scala-mode/scala-mode-inf" "\
Send whole buffer to Scala interpreter.

\(fn)" t nil)

(autoload 'scala-load-file "scala-mode/scala-mode-inf" "\
Load a file in the Scala interpreter.

\(fn FILE-NAME)" t nil)

(autoload 'scala-quit-interpreter "scala-mode/scala-mode-inf" "\
Quit Scala interpreter.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("el-get/el-get-autoloads.el" "el-get/el-get-build.el"
;;;;;;  "el-get/el-get-byte-compile.el" "el-get/el-get-core.el" "el-get/el-get-custom.el"
;;;;;;  "el-get/el-get-dependencies.el" "el-get/el-get-install.el"
;;;;;;  "el-get/el-get-methods.el" "el-get/el-get-notify.el" "el-get/el-get-recipes.el"
;;;;;;  "el-get/el-get-status.el" "ensime/src/main/elisp/auto-complete.el"
;;;;;;  "ensime/src/main/elisp/ensime-auto-complete.el" "ensime/src/main/elisp/ensime-builder.el"
;;;;;;  "ensime/src/main/elisp/ensime-comint-utils.el" "ensime/src/main/elisp/ensime-config.el"
;;;;;;  "ensime/src/main/elisp/ensime-debug.el" "ensime/src/main/elisp/ensime-doc.el"
;;;;;;  "ensime/src/main/elisp/ensime-inf.el" "ensime/src/main/elisp/ensime-refactor.el"
;;;;;;  "ensime/src/main/elisp/ensime-sbt.el" "ensime/src/main/elisp/ensime-scalex.el"
;;;;;;  "ensime/src/main/elisp/ensime-search.el" "ensime/src/main/elisp/ensime-semantic-highlight.el"
;;;;;;  "ensime/src/main/elisp/ensime-test.el" "ensime/src/main/elisp/ensime-ui.el"
;;;;;;  "ensime/src/main/elisp/ensime-undo.el" "ensime/src/main/elisp/ensime.el"
;;;;;;  "ensime/src/main/elisp/fuzzy.el" "ensime/src/main/elisp/popup.el"
;;;;;;  "python-mode/python-mode.el" "scala-mode/scala-mode-auto.el"
;;;;;;  "scala-mode/scala-mode-constants.el" "scala-mode/scala-mode-feature-electric.el"
;;;;;;  "scala-mode/scala-mode-feature-speedbar.el" "scala-mode/scala-mode-feature-tags.el"
;;;;;;  "scala-mode/scala-mode-feature.el" "scala-mode/scala-mode-fontlock.el"
;;;;;;  "scala-mode/scala-mode-indent.el" "scala-mode/scala-mode-lib.el"
;;;;;;  "scala-mode/scala-mode-navigation.el" "scala-mode/scala-mode-ui.el"
;;;;;;  "scala-mode/scala-mode-variables.el") (20632 42934 924075))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
