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

(defvar home-dir (substring (shell-command-to-string "echo $HOME") 0 -1)
  "String of the home directory's absolute path.")

(defvar clang-cflags '("-Wall" "--std=c11"))
(defvar clang-include-directories (mapcar (lambda (dir) (concat home-dir dir)) '("/Programming/c/moolang")))
(defvar clang-pkg-config-cflags '("gtk4")
  "Used in CLANG-PKG-CONFIG to generate compile flags.")

(defun clang-directories-with-header-files (in)
  "Return a list of strings representing directories with header files.
Header file are searched recursively from starting point IN."
  (let ((header-files (delete-dups (split-string (shell-command-to-string (format "find %s -name \"*.h\"" in))))))
    (let ((directories (mapcar (lambda (in) (replace-regexp-in-string "/[^/]*$" "" in)) header-files)))
      (delete-dups directories))))

(defun clang-pkg-config ()
  "Configure compiler flags with pkg-config using the variable CLANG-PKG-CONFIG-CFLAGS."
  (let ((flags (mapconcat 'identity clang-pkg-config-cflags " ")))
    (let ((command (concat "pkg-config --cflags " flags)))
      (butlast (split-string (shell-command-to-string command) " " t)))))

(defun clang-flags ()
  "Return a list of c compiler flags as strings."
  (append (mapcar (lambda (dir) (concat "-I" dir)) (apply 'append (mapcar 'clang-directories-with-header-files clang-include-directories)))
	  `(,(concat "-I" home-dir "/.local/lib"))
	  clang-cflags
	  (clang-pkg-config)))
	  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "/tmp/" t)))
 '(backup-directory-alist '((".*" . "/tmp/")))
 '(byte-compile-verbose nil)
 '(byte-compile-warnings '(cl-functions))
 '(c++-mode-hook '(irony-mode flycheck-mode))
 '(c-default-style
   '((c-mode . "linux")
     (c++-mode . "linux")
     (objc-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "linux")))
 '(c-mode-common-hook
   '(c-toggle-auto-hungry-state subword-mode c-toggle-auto-newline
				(lambda nil
				  (local-set-key
				   (kbd "C-c M-d")
				   'gdb))))
 '(c-mode-hook '(macrostep-c-mode-hook irony-mode flycheck-mode))
 '(column-number-mode t)
 '(company-backends
   '(company-bbdb company-semantic company-clang company-cmake company-capf company-files
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-dabbrev company-irony-c-headers company-irony))
 '(company-clang-arguments (clang-flags))
 '(compile-command "make")
 '(custom-enabled-themes '(red))
 '(custom-safe-themes
   '("6c531d6c3dbc344045af7829a3a20a09929e6c41d7a7278963f7d3215139f6a7" "c4d4dab421ca2fe67c48d228ee671c19dfd7619f8299c706f5dc90bafe606446" "9b2990d521333ddd9272bfd2310707a5d2ccf61f6d7a428b33889186b991b45a" "7059ca7d9b0999e24582b4330d5ca95478a8618fba28a6262fee04ba53b8d117" "e5d8cae0ea67516a52078399d4c42248484de943710cbb051832f5540cb1cdc7" "e4805de8bbea12b6b79dc1f3f9c45df851f17fef0bcb3200804f36c892910a71" "9435e221c630319d36b0781a90b33eeac75220816d142e88876242e8c3ab6a07" "2aa2ad7273a4aedc143cef4b4446dc98fe349dddbbcab169ad063521580bcbe9" "420d0c44b2450274e559354143bb98875dcc46964cb6ffe551f2c12dde9c8e9a" "3df701d427b724e67a2bc19d9380267ed9aa1b74121c62a63799b520634dc597" "c0276435a2fbf3fc0adcc8555579c565fb3050f83dc921b98c3f826f4c93433b" "feb0a5054d55b1236ff6d021202aa1121155802752393d2966101da585227b53" "7d6779899e1982c7fe433eb1b079dc3fc0aab844f1108b65968cefa89e18ea53" "946304240d8b95a03a0e5ade5519c9b4fe9fc5fcb3d39b9d8b5baf84edd6e1f0" "e93e0dae8e5c3df21b2ae9cc821de404a416c8bd3d32cfa2b4995b28a3b8ef30" "d51f08d4bd9ca3b3f8c92da8fe45b679588a35b79243d00b7984ddeefaac40fe" "dad1a7a1dbed53a89a4e9490a9bc7b301fe4d60ce6a83706ac78a040f955c2bc" "ecf6775a9b14c30862c85c9bd4e64adcd6731c20c86f3d12c46037595b2ad75e" "b070bf5e2ec5045a17462d1f7e3e1830ad6b814d16386a28777e605864ca8302" "76ac163f6e7592528c88972c2cebee87f5ce6dc07d2363dec5283180ca3b8740" "e5602b160cd64f4deafb46ac3dd1b95b2d106a44b5cb258792d8f04a1508e36d" "2c0dd3d2dbd4ff8b558b4c1d26d9fd778e2db98aa80b94ec01cb604fb4fe7dd0" "2bc0fb7cfa41de1dd159883d4c8fb1ea809de724a57c1abdecd62d67cf2976d7" "5823ca629ca9e2d5ddcbf76ec410d80aa854d92fd60188ed8a3b1a603f3095ba" "93652989094a5ca5910581fd98948deb18d3f7f632d1818a547435e1f6f0e39d" "2b6dc28bd1eacda4b6a03a4eede70724abf685c2dd3e40bf4632f5409d31fe01" "9af9b27ea4f8949aa843e65711d97247f43cec05aaff7bb6ae985b49000088c7" "9433f24a7027e4928bf0fec7429c6025c990e1681046beed31613d0cb6fb9192" "785fda83fd8d6e979a15809fd003029828c8236d003b0dd7f23e54e8927f85e9" "27dd6cfd76351095fd3083057387fbb504a837e893bc5377ac6623c33700431d" "f9ecdae6a42df3eeb42547109fd9cf0ad458e546f0cadc8fdc1b0234be60ef07" "ec77044f85f5a836fa3c7eb5073730201a8f413f96935068e3739349e6b90c0f" "85bf9f4eeaa65282d318731c162b5a19183e091733163dfc88fe2cf7878c01fb" "7305b87681de17ee75c47196f65d8d3ba3401dd6170e6abd3b7bc5b31a4ed82c" "b9ebc1d28c4727d5bd02d851e10c2249d5199a448016c7f4e8cee90e06017025" "6730df0fac31a5303e6900b72a3c7ae635371a8b40a60ae6bb31a75e68c1070f" "bb08a00eee1407d04d88c9e24f0ac58d8004a5ee19faea7e86f4053f9df825cf" "c530cca688afd08d3613f64685abf3433e60cc29b25ec87b1c10f8bfa1093b2d" "bcfebb42719dc9c771448d387259f962fa9fe9175cb71e3a7c4c39295f63dcf8" "5acaafd1f4621c7dfb4fa16c78f3c928c7045d7f7aaa7bd6c61871b640ff0927" "1eff6ab5092bce78741407fa122beefe79f776d58161a30a9347cd6c0affc62e" "f41bd65bd4443db5b848c0974c926bd20ad25aedea2eb99610943e07eb2bae23" "77f76118c3d693ae1b1726b35c67bb49ea2cca09919db132db0eb931cbe9c125" "3023052e69fc110424cc46e7e8be989b5e4cf0114d213699a11e46a985473762" "c6fadb36a0657b60b29df5d0b7bfe798fc724e52073434cde51934cb84e1307e" "3910d1d203f9e027e7301ed8970349cb788986d6c953f7058019093a7fd67ba0" "c1fd251beaab5a0b2b674fe75331eb752256ef73840cd9298d6e050fdb9bf0f1" "8df51d8e74e694aa97e5fd7b0eff526c20b25736a161b68e51499f5a86033fa5" "f43e9cc2aebb6cf3ac143b5dbe41ebd918db8b31b0e706f6a9f991ae73460baf" "8da553fff9af67f75ff4bbfcc0a06831c1dacf8013522020f46f39b0cd67159c" "e1592c68ae78b592b2589c962cdd1ececdc8fd0531f287dd90250a4574adfe22" "e346006f36f5fb162c8e3ed2a81f13def88320f0fbdb2a06ddd74dbc74dcbad9" "4887d74932f46f5e6e7f0f280eecb1e9c3f74f6f99ac5cad34e54e5f6e38325d" "0ebd25fa6d07376b4eecfd1ba589bc1906be66dc5188db6dddfba2fcebad0125" "995f393d6ab98a395ae247b66bf35fae6745e798cbb507b9cf3033c5edeeff58" "f1bca84edca147cabbd7b8e1981eae610241e5cd9d49d1db963e75381fd3eed2" "609f20b898f91e422aa352a6f486fb439ef8b2b39bc3e588b1ad8e026186684e" "4f0e0c56fe152a47415f80fa4148d4e8218d98bed5a8ab06b28a0ec2005bdc96" "ad15364bb248fa5ee650e55b5b79e510cc14383e829d0b5c39a7d55d4adf5094" "4b05fc37b32c8728b15d0fbd446c3429c3c8d3b3f48c4458506a25e7202d169e" "5bb2e5de7945ae621e4e502a623f1fa71514d1dc481e1b76e20f4f3133ccc518" "8ee7cf409c63f0c054ae286d4eda334b4f920893f6cb9b35342327470bcf4e5f" "d1f23e42ea6d3f70d74773442b1a851cb2181675ca4290bbd486389361197623" "8f536bd5630d510c3c423911403624280da065c56bb17d11601fd2bd0998fd64" "8713f403f4d783ceb834be7444741f690968f13b71519be4c6f4cb9e6dd16eda" "5784d048e5a985627520beb8a101561b502a191b52fa401139f4dd20acb07607" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "11cc0b4e0e97d45b0201ae8d4a485fbc03fd746905e72d0e4a69a12f045951c4" "7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" default))
 '(display-line-numbers 'visual)
 '(doom-modeline-mode t)
 '(ede-project-directories
   '("/home/roland/Programming/c/new_language" "/home/roland/Programming/Test"))
 '(flycheck-clang-args (clang-flags))
 '(flycheck-clang-include-path nil)
 '(flycheck-mode-hook
   '(flycheck-mode-set-explicitly doom-modeline-update-flycheck-text doom-modeline-update-flycheck-icon flycheck-irony-setup))
 '(initial-buffer-choice t)
 '(initial-major-mode 'fundamental-mode)
 '(initial-scratch-message nil)
 '(irony-additional-clang-options (clang-flags))
 '(ivy-count-format "(%d/%d) ")
 '(ivy-mode t)
 '(ivy-use-virtual-buffers t)
 '(ivy-wrap t)
 '(org-hide-leading-stars t)
 '(org-support-shift-select nil)
 '(package-selected-packages
   '(flycheck-irony company-irony-c-headers company-irony flycheck-rust eshell-vterm cmake-mode gdscript-mode rust-mode vala-mode magit focus flymake markdown-mode paredit darkroom olivetti slime ivy doom-themes doom-modeline))
 '(prog-mode-hook
   '(flycheck-mode company-mode
		   (lambda nil
		     (local-set-key
		      (kbd "C-c M-c")
		      'compile))))
 '(rcirc-server-alist '(("irc.libera.chat" :nick "spowmtom")))
 '(recentf-mode t)
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
 '(default ((t (:family "Comic Code Ligatures" :foundry "TAB " :slant normal :weight semi-bold :height 128 :width normal))))
 '(mode-line ((t nil)))
 '(mode-line-highlight ((t nil)))
 '(mode-line-inactive ((t nil))))

;; Convenience
(fset 'yes-or-no-p 'y-or-n-p)

;; Bindings
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-s i") 'imenu)

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

(provide 'init.el)
;;; init.el ends here
