;;; renpy-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "renpy" "renpy.el" (0 0 0 0))
;;; Generated autoloads from renpy.el

(add-to-list 'auto-mode-alist '("\\.rpy\\'" . renpy-mode))

(autoload 'renpy-mode "renpy" "\
Major mode for editing Renpy files.
Turns on Font Lock mode unconditionally since it is currently required
for correct parsing of the source.
See also `jython-mode', which is actually invoked if the buffer appears to
contain Jython code.  See also `run-renpy' and associated Renpy mode
commands for running Renpy under Emacs.

The Emacs commands which work with `defun's, e.g. \\[beginning-of-defun], deal
with nested `def' and `class' blocks.  They take the innermost one as
current without distinguishing method and class definitions.  Used multiple
times, they move over others at the same indentation level until they reach
the end of definitions at that level, when they move up a level.
\\<renpy-mode-map>
Colon is electric: it outdents the line if appropriate, e.g. for
an else statement.  \\[renpy-backspace] at the beginning of an indented statement
deletes a level of indentation to close the current block; otherwise it
deletes a character backward.  TAB indents the current line relative to
the preceding code.  Successive TABs, with no intervening command, cycle
through the possibilities for indentation on the basis of enclosing blocks.

\\[fill-paragraph] fills comments and multi-line strings appropriately, but has no
effect outside them.

Supports Eldoc mode (only for functions, using a Renpy process),
Info-Look and Imenu.  In Outline minor mode, `class' and `def'
lines count as headers.  Symbol completion is available in the
same way as in the Renpy shell using the `rlcompleter' module
and this is added to the Hippie Expand functions locally if
Hippie Expand mode is turned on.  Completion of symbols of the
form x.y only works if the components are literal
module/attribute names, not variables.  An abbrev table is set up
with skeleton expansions for compound statement templates.

\\{renpy-mode-map}

\(fn)" t nil)

(register-definition-prefixes "renpy" '("renpy-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; renpy-autoloads.el ends here
