# Mi Configuración de Emacs (jp-emacs)

Esta es mi configuración personal de Emacs. Está diseñada para ser ligera, rápida y enfocada en el desarrollo de C, Java y Flutter, usando una filosofía "modal" moderna (sin modos).

## Características

* **UI Moderna:** `doom-modeline`, `treemacs` y tema `gruvbox` con iconos.
* **Edición Híbrida:** Atajos `C-c/C-v/C-z` (CUA) + navegación nativa de Emacs.
* **Búsqueda Rápida:** `vertico` y `consult`.
* **IDE:** `lsp-mode`, `flycheck` (errores) y `yasnippet` (snippets).
* **Git:** ¡El increíble `magit`!

## Instalación

1. Asegúrate de tener Emacs instalado.
2. Respalda tu `~/.emacs.d` actual: `mv ~/.emacs.d ~/.emacs.d.bak`
3. Clona este repositorio:
   ```bash
   git clone [https://github.com/CodigoPeraza/jpmacs.git] (https://github.com/CodigoPeraza/jpmacs.git) ~/.emacs.d
