(setq-default
        compilation-scroll-output t
        grep-scroll-output t
        scroll-preserve-screen-position 'always
        tab-width 4
        mouse-wheel-progressive-speed t
        x-select-enable-clipboard t
        require-final-newline t
        parens-require-spaces nil
        kill-ring-max 1024
        view-read-only t
        comment-style 'multi-line
        auto-save-default nil
        make-backup-files nil
        read-file-name-completion-ignored-cas t
        frame-title-format '(" %f")
        user-mail-address "Mapleaph@gmail.com"
        user-full-name "Michael Wu"
        sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
        scroll-margin 3 scroll-conservatively 10000)

;; BEGIN: wk-misc-init
(defun wk-misc-init ()
  (global-linum-mode)
  (auto-image-file-mode)
  (mouse-avoidance-mode 'animate))
;; END: wk-misc-init

(wk-misc-init)

;; BEGIN: wk-key-init
(defun wk-key-init()
  ;; goto line
  (global-set-key (kbd "M-g") 'goto-line)
  ;; comment-dwim
  (global-set-key "\C-c\C-c" 'comment-dwim)
  ;; set mark
  (global-set-key "\M-m" 'set-mark-command)
  ;; bind delete-other-windows with <f1>
  (define-key global-map [(f1)] 'delete-other-windows)
  ;; key binding for elisp-index-search
  (global-set-key (kbd "<f8>") 'elisp-index-search)
  ;; jump to speedbar frames
  (global-set-key (kbd "<f5>") 'speedbar-get-focus))
(wk-key-init)
;; END: wk-key-init

;; BEGIN: wk-c-mode-common-hook
(defun wk-c-mode-common-hook()
  (c-set-style "K&R")
  (c-toggle-auto-hungry-state t)
  (define-key c-mode-base-map [(return)] 'newline-and-indent))
(add-hook 'c-mode-common-hook 'wk-c-mode-common-hook)
;; END: wk-c-mode-common-hook


;; BEGIN: auctex
(mapc (lambda (mode)
		(add-hook 'LaTeX-mode-hook mode))
	  (list 'LaTeX-math-mode
			'turn-on-reftex
			'linum-mode))

(add-hook 'LaTeX-mode-hook
		  '(lambda ()
			 (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
			 (setq TeX-command-default "XeLaTeX")
			 (setq TeX-save-query nil)
			 (setq TeX-show-compilation t)
			 (setq TeX-auto-untabify t
				   TeX-engine 'xetex)
			 (TeX-global-PDF-mode t)
			 (imenu-add-menubar-index)
			 (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
			 ))
;; END: auctex


;; BEGIN: latex skeleton
(define-skeleton latex-skeleton
  "Inserts a Latex page skeleton into current buffer."
  nil
  "\\documentclass[a4paper]{article}\n"
  "\\usepackage{xcolor}\n"
  "\\usepackage{fontspec}\n"
  "\\setmainfont{Microsoft YaHei}\n"
  "\\usepackage{zhspacing}\n"
  "\\usepackage{setspace}\n"
  "\\usepackage[colorlinks,linkcolor=blue]{hyperref}"
  "\\usepackage{listings}\n"
  "\\usepackage{courier}\n"
  "\\lstset{\n"
  "  language={bash},\n"
  "  %numbers=left,\n"
  "  numberstyle=\\tiny,\n"
  "  %stepnumber=2,\n"
  "  numbersep=5pt,\n"
  "  backgroundcolor=\\color{lightgray},\n"
  "  tabsize=4,\n"
  "  showtabs=false,\n"
  "  showspaces=false,\n"
  "  breaklines=true,\n"
  "  extendedchars=true,\n"
  "  framexleftmargin=10pt,\n"
  "  xleftmargin=10pt,\n"
  "  keywordstyle=\\color{red},\n"
  "  stringstyle=\\color{white},\n"
  "  showstringspaces=false\n"
  "}\n"
  "\\setlength{\\textwidth}{450pt}\n"
  "\\setlength{\\oddsidemargin}{0pt}\n"
  "\\setlength{\\topmargin}{0pt}\n"
  "\\setlength{\\headheight}{0pt}\n"
  "\\setlength{\\headsep}{0pt}\n"
  "\\setlength{\\parindent}{2em}\n"
  "\\setlength{\\textheight}{700pt}\n"
  "\\pagestyle{empty}\n"
  "\\begin{document}\n"
  "\\title{ " - " }\n"
  "\\maketitle\n"
  "\\begin{spacing}{2}\n"
  "\\begin{large}\n"
  "\\begin{enumerate}\n"
  "\\item\n"
  "\\end{enumerate}\n"
  "\\end{large}\n"
  "\\end{spacing}\n"
  "\\end{document}\n")

(global-set-key "\C-cl" 'latex-skeleton)
;; END: latex skeleton

;; BEGIN: toggle-line-spacing
(defun toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height."
  (interactive)
  (if (eq line-spacing nil)
	  (setq-default line-spacing 0.5)
	(setq-default line-spacing nil)))
;; ENS: toggle-line-spacing

(require 'xcscope)

(provide 'init-local)
