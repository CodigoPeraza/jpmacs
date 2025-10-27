;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PREÁMBULO: GESTOR DE PAQUETES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Forzar "true color" para que Starship y los temas funcionen
(setenv "COLORTERM" "truecolor")

;; Evitar la pantalla de inicio de Emacs por defecto
(setq inhibit-startup-message t)

;; Instalar use-package (si no está)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PARTE 1: ERGONOMÍA BÁSICA (CUA, ATAJOS, WHICH-KEY)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Activar CUA-Mode (Ctrl+C, Ctrl+V, Shift+Selección)
(cua-mode t)
(setq cua-enable-cua-keys t)

;; Atajos modernos (C-z para Deshacer)
(global-set-key (kbd "C-z") 'undo)

;; which-key (Ayuda de atajos)
(use-package which-key
  :config
  (which-key-mode))
;; Activar la auto-indentación "eléctrica" (que 'Enter' indente solo)
(electric-indent-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PARTE 2: NÚCLEO INTERACTIVO (VERTICO, CONSULT, RECENTF, PROJECTILE)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Vertico (Interfaz vertical para el minibuffer)
(use-package vertico
  :config
  (vertico-mode t))

;; Consult (Comandos de búsqueda mejorados)
(use-package consult
  :bind (
         ;; C-x C-r = Archivos Recientes
         ("C-x C-r" . consult-recent-file)
         ;; C-x b = Cambiar de Búfer
         ("C-x b" . consult-buffer)
         ;; M-g l = Buscar línea en todos los búferes
         ("M-g l" . consult-line)
        ))

;; Historial de archivos nativo (para consult-recent-file)
(recentf-mode t)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)

;; Gestor de Proyectos
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PARTE 3: TEMA E INTERFAZ "ESPECTACULAR" (GRUVBOX, ICONOS, MODELINE, TREEMACS)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Tema Gruvbox
(use-package gruvbox-theme
  :init
  ;; Fondo transparente
  (setq gruvbox-transparent-background t)
  :config
  ;; Carga la variante
  (load-theme 'gruvbox-dark-hard t))

;; Instalador de iconos (necesario para doom-modeline y treemacs)
(use-package all-the-icons)

;; Barra de estado moderna
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-project-detection 'project)) ; Que use projectile

;; Explorador de archivos
(use-package treemacs
  :bind (
         ;; C-x C-t = Abrir/Cerrar Treemacs
         ("C-x C-t" . treemacs)
        )
  :config
  (treemacs-follow-mode t)) ; Que siga al archivo que abres

(use-package treemacs-projectile
  :after (treemacs projectile)) ; Conexión entre treemacs y projectile

;; Ocultar las barras de herramientas visuales
;;(tool-bar-mode -1)   ;; Oculta la barra de botones (en GUI)
;;(scroll-bar-mode -1) ;; Oculta la barra de scroll (en GUI)
;;(menu-bar-mode -1)   ;; Oculta la barra de menu en la TUI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PARTE 4: HERRAMIENTAS (VTERM, MAGIT)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Terminal VTerm
(use-package vterm
  :config
  (setq vterm-shell shell-file-name))

;; Magit (Cliente de Git)
(use-package magit
  :bind (("C-x g" . magit-status)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PARTE 5: PROGRAMACIÓN (LSP, COMPLETADO, ERRORES, SNIPPETS)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Autocompletado (Company)
(use-package company
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.3))

;; Language Server Protocol (LSP)
(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-completion-provider :company))
(use-package lsp-ui)

;; Corrector de errores (Squiggles)
(use-package flycheck
  :config
  (global-flycheck-mode t)) ; Actívalo globalmente

;; Snippets (Plantillas de código)
(use-package yasnippet
  :config
  (yas-global-mode 1)) ; Actívalo globalmente

;; Hooks de Lenguajes (Java, C, Flutter/Dart)
(use-package dart-mode
  :hook (dart-mode . lsp))
(add-hook 'java-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                             Bindings                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c t") 'vterm)

;;; --- FIN DE LA CONFIGURACIÓN ---
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
