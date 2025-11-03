# Luke's Neovim Setup
Luke’s Neovim Setup

![Neovim setup screenshot](./example_screenshot.png)

A clean, modern Neovim configuration built for **C/C++** and **embedded systems** development.
Uses `lazy.nvim` for plugin management, `clangd` for LSP, and a dark transparent theme (`catppuccin`).

## Features

- **LSP & Autocomplete** — clangd + nvim-cmp for smart completion
- **Lazy Plugin Manager** — easy plugin management
- **Treesitter** — syntax highlighting & folding
- **Catppuccin Theme** — transparent background
- **Telescope** — fuzzy file search
- **Nvim-tree** — file explorer with Git integration
- **Gitsigns** — Git diff signs in gutter
- **Lualine** — clean statusline
- **Todo-comments** — highlights TODO/FIX/NOTE tags
- **Resize Mode** — `<leader>r + hjkl` to resize splits
- **Custom Keymaps** — efficient navigation & diagnostics
- **Custom LSP Hover** — K shows docs or signature help intelligently
- **ToggleTerm** — drop-down terminal (:T) for quick commands

---

## Installation

1. Clone this repo:
    ```bash
    git clone https://github.com/<your-username>/nvim ~/.config/nvim
2. Start Neovim — Lazy will auto-install plugins on first run:
    ```bash
    nvim
3. Run `:Lazy` to view/manage plugins.
4. (Optional) Run `:checkhealth` to verify setup.

---

## Keymaps

### Window Management

| Action | Shortcut |
|--------|-----------|
| Move focus left | `<leader>h` |
| Move focus down | `<leader>j` |
| Move focus up | `<leader>k` |
| Move focus right | `<leader>l` |
| Toggle resize mode | `<leader>r` then `h/j/k/l` |
| Save and close window | `<BS>` |
| Cycle through windows | `<Tab>` |

### Navigation & File Explorer

| Action | Shortcut |
|--------|-----------|
| Toggle file explorer | `<leader>e` |
| Fuzzy find files | `<leader>ff` |
| Jump to next TODO (cycle + wrap) | `<leader>t` |

### LSP & Diagnostics

| Action | Shortcut |
|--------|-----------|
| Show hover docs or function signature | `K` |
| Show signature help (always) | `<leader>s` |
| Go to definition | `gd` |
| Show diagnostic popup | `<C-d>` |
| Jump to next diagnostic | `]d` |
| Jump to previous diagnostic | `[d` |

### Terminal & Markdown

| Action | Shortcut |
|--------|-----------|
| Toggle horizontal terminal | `:T` |
| Markdown preview | `<leader>mp` |

---

## Notes

- Uses `clangd` for C/C++ (requires LLVM tools installed)
- Set leader key to `<Space>`
- Indent set to 4 spaces globally
- Works on macOS and Linux
- For proper transparency and background image rendering on macOS, use **iTerm2** instead of the default Terminal app
