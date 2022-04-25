;;; init.el --- Tohan Marchand's Emacs config  -*- lexical-binding: t -*-

;; Maintainer:		Tohan Marchand <tohan.marchand@protonmail.com>
;; Created: 		2021 12th of April
;; Keywords: 		init.el .emacs config
;; Version: 		20210818.1

;;;; License and Commentary

;;     Copyright (C) 2021 Tohan Marchand <tohan.marchand@protonmail.com>
;;
;;     This program is free software; you can redistribute it and/or
;;     modify it under the terms of the GNU General Public License as
;;     published by the Free Software Foundation; either version 2 of
;;     the License, or (at your option) any later version.
;;
;;     This program is distributed in the hope that it will be useful,
;;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;     GNU General Public License for more details.
;;
;;     You should have received a copy of the GNU General Public
;;     License along with this program; if not, write to the Free
;;     Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;;     MA 02111-1307, USA.

;;; Commentary:

;; This file is automatically evaluated when Emacs first loads.
;; It contains automatic configurations setup by Emacs' Easy Customization,
;; requires, Melpa, custom functions such as duplicate-line, hooks, my ID and
;; defined variables such as load-path.
;; TRY TO USE EASY CUSTOMIZATION AS MUCH AS POSSIBLE!

;;; Code:

;;; Variables

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "/tmp/" t)))
 '(backup-directory-alist '((".*" . "/tmp/")))
 '(byte-compile-verbose nil)
 '(byte-compile-warnings '(cl-functions))
 '(c-default-style
   '((c-mode . "linux")
     (c++-mode . "linux")
     (objc-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "linux")))
 '(c-mode-common-hook
   '(c-toggle-auto-hungry-state subword-mode lsp c-toggle-auto-newline
				(lambda nil
				  (local-set-key
				   (kbd "C-c M-d")
				   'gdb))))
 '(column-number-mode t)
 '(company-backends
   '(company-bbdb company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-dabbrev company-omnisharp))
 '(custom-enabled-themes '(doom-gruvbox))
 '(custom-safe-themes
   '("7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" default))
 '(display-line-numbers 'visual)
 '(doom-modeline-mode t)
 '(ede-project-directories '("/home/roland/Programming/Test"))
 '(initial-buffer-choice t)
 '(initial-major-mode 'fundamental-mode)
 '(initial-scratch-message nil)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-mode t)
 '(ivy-use-virtual-buffers t)
 '(ivy-wrap t)
 '(lsp-completion-enable nil)
 '(lsp-completion-provider :none)
 '(lsp-enable-on-type-formatting nil)
 '(lsp-enable-snippet nil)
 '(org-hide-leading-stars t)
 '(org-support-shift-select nil)
 '(package-selected-packages
   '(omnisharp csharp-mode cmake-mode company-shell company gdscript-mode renpy lsp-ivy rust-mode vala-mode lsp-mode magit janet-mode paredit-everywhere focus flymake markdown-mode vterm paredit darkroom olivetti slime ivy doom-themes doom-modeline))
 '(prog-mode-hook
   '(flyspell-prog-mode flymake-mode paredit-everywhere-mode company-mode
			(lambda nil
			  (local-set-key
			   (kbd "C-c M-c")
			   'compile))))
 '(rcirc-server-alist '(("irc.libera.chat" :nick "spowmtom")))
 '(scroll-bar-mode nil)
 '(sentence-end "\\. +")
 '(size-indication-mode t)
 '(small-temporary-file-directory "/tmp/")
 '(standard-indent 8)
 '(tool-bar-mode nil)
 '(user-full-name "Tohan Marchand")
 '(user-mail-address "tohan.marchand@protonmail.com")
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Comic Code Ligatures" :foundry "TAB " :slant normal :weight semi-bold :height 128 :width normal)))))

;; Convenience
(fset 'yes-or-no-p 'y-or-n-p)

;; Bindings
(global-set-key (kbd "C-x C-b") 'ibuffer)

(add-to-list 'load-path "~/.emacs.d/lisp")

;;; Requires

;; Melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Emacs 27 automatically initializes packages
;; (package-initialize)


;;; Functions

(defun kill-dialogue ()
  "Kills the current emacs terminal."
  (interactive)
  (if (y-or-n-p "Kill terminal ? ")
      (save-buffers-kill-terminal)))

(defun create-scratch-buffer ()
  "Create a new *scratch* buffer."
  (interactive)
  (switch-to-buffer-other-window "*scratch*")
  (if initial-scratch-message
      (insert initial-scratch-message))
  (goto-char (point-max))
  (if initial-major-mode
      (initial-major-mode)))

(defun duplicate-char (&optional arg)
  "Duplicates the character on which the point is.
ARG defaults to 1."
  (interactive "p")
  (dotimes (i (cond (arg arg) 1))
    (let ((text (buffer-substring-no-properties (point) (+ (point) 1))))
      (insert text))))

(defun duplicate-word (&optional arg)
  "Duplicate the word the point is on.
ARG defaults to 1."
  (interactive "p")
  (dotimes (i (cond (arg arg) 1))
    (insert (word-at-point))))

(defun duplicate-sentence (&optional arg)
  "Duplicate current sentence.
ARG defaults to 1."
  (interactive "p")
  (dotimes (i (cond (arg arg) 1))
    (insert (sentence-at-point))))

(defun duplicate-line (&optional arg)
  "Duplicate current line.
ARG defaults to 1."
  (interactive "p")
  (let ((line (buffer-substring-no-properties
	       (line-beginning-position) (line-end-position))))
    (dotimes (i (cond (arg arg) 1))
      (move-beginning-of-line 1)
      (insert line "\n"))))

(defun insert-lambda (&optional arg)
  "Insert the lambda (λ) character.
ARG defaults to 1."
  (interactive "p")
  (dotimes (i (cond (arg arg) 1))
    (insert "λ")))

(defun kill-to-line-beginning-position (&optional arg)
  "Kill region from beginning of line to point, similar to C-u in Bash and Nano.
ARG defaults to 1."
  (interactive "p")
  (dotimes (i (cond (arg arg) 1))
    (kill-region (line-beginning-position) (point))))

(global-set-key (kbd "C-x C-l") 'insert-lambda)
(global-set-key (kbd "C-x C-d") 'duplicate-line)
(global-set-key (kbd "C-x M-d") 'duplicate-sentence)
(global-set-key (kbd "C-x M-w") 'duplicate-word)
(global-set-key (kbd "C-u") 'kill-to-line-beginning-position)
(global-set-key (kbd "C-x C-c") 'kill-dialogue)

;;; Hooks
; (add-hook 'csharp-mode-hook 'lsp)

(provide 'init.el)
;;; init.el ends here
