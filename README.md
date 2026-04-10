# <h1 align="center">❄️ WinLand: The Linux-Style Tiling WM for Windows</h1>

<p align="center">
  <b>Forget the floating window chaos. Bring the power of a Linux-style Tiling Window Manager (TWM) to Windows.</b>
  <br />
  <i>A pixel-perfect, keyboard-driven workflow designed for developers and power users.</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Workflow-Keyboard--Driven-blueviolet?style=for-the-badge&logo=windows" alt="Workflow" />
  <img src="https://img.shields.io/badge/Terminal-WezTerm-orange?style=for-the-badge&logo=wezterm" alt="Terminal" />
  <img src="https://img.shields.io/badge/WM-Komorebi-green?style=for-the-badge&logo=komorebi" alt="WM" />
  <img src="https://img.shields.io/badge/UI-YASB-blue?style=for-the-badge&logo=css3" alt="UI" />
</p>

---

## ✨ Features

- **🚀 Instant Deployment:** One-script setup for all requirements (Scoop, AHK, Python).
- **🪟 True Tiling:** Powered by `Komorebi` for automatic window management.
- **📟 Modern Terminal:** GPU-accelerated `WezTerm` with ligatures and blur support.
- **📊 Aesthetic Status Bar:** `YASB` (Yet Another Status Bar) for a clean, CSS-styled top bar.
- **⌨️ AHK Integration:** Unified hotkeys for a seamless "Hyprland-like" feel.

## 🛠️ Quick Start

### 1. Requirements
- **PowerShell 7** (Run as Admin)
- **Git**

### 2. One-Command Setup
Clone this "rice" and deploy your new environment instantly:

```powershell
git clone https://github.com/El-Darawii/WinLand.git $HOME\dotfiles; cd $HOME\dotfiles; .\scripts\install.ps1
```

## ⌨️ Keybindings

### Komorebi (Window Manager)

| Shortcut | Action |
| :--- | :--- |
| `Win + H` | Focus Left |
| `Win + J` | Focus Down |
| `Win + K` | Focus Up |
| `Win + L` | Focus Right |
| `Win + Shift + H` | Move Window Left |
| `Win + Shift + J` | Move Window Down |
| `Win + Shift + K` | Move Window Up |
| `Win + Shift + L` | Move Window Right |
| `Win + Alt + H` | Resize Horizontal Decrease |
| `Win + Alt + J` | Resize Vertical Increase |
| `Win + Alt + K` | Resize Vertical Decrease |
| `Win + Alt + L` | Resize Horizontal Increase |
| `Win + 1-9` | Switch to Workspace 1-9 |
| `Win + Shift + 1-9` | Move Window to Workspace 1-9 |
| `Win + F` | Toggle Monocle (Fullscreen) |
| `Win + W` | Close Window |
| `Win + Shift + F` | Flip Layout Vertical |
| `Win + Shift + V` | Flip Layout Horizontal |
| `Win + \` | Toggle BSP/Scrolling Layout |
| `Win + [` | Cycle Focus Previous |
| `Win + ]` | Cycle Focus Next |
| `Win + Ctrl + R` | Restart Komorebi |

### Application Launchers

| Shortcut | Action |
| :--- | :--- |
| `Win + Enter` | Launch WezTerm |
| `Win + N` | Launch Neovim (Alacritty) |
| `Win + B` | Launch Brave |
| `Win + E` | Open Explorer |
| `Win + D` | Launch Discord |
| `Win + Shift + W` | Launch WhatsApp |
| `Win + M` | Launch Spotify |
| `Win + Space` | Send Alt+Space (Start Menu) |

### WezTerm (Terminal)

| Shortcut | Action |
| :--- | :--- |
| `Ctrl + Space` | Leader Key (tmux-style) |
| `Leader + V` | Split Vertical |
| `Leader + H` | Split Horizontal |
| `Leader + X` | Close Pane |
| `Leader + Z` | Toggle Pane Zoom |
| `Leader + C` | New Tab |
| `Leader + K` | Close Tab |
| `Leader + R` | Rename Tab |
| `Leader + S` | Show Launcher (Workspaces) |
| `Leader + N` | Next Workspace |
| `Leader + P` | Previous Workspace |
| `Ctrl + Alt + Arrow` | Navigate Panes |
| `Ctrl + Alt + Shift + Arrow` | Resize Panes |
| `Alt + 1-9` | Switch to Tab 1-9 |
| `Alt + Left/Right` | Previous/Next Tab |
| `Ctrl + =/-` | Font Size +/- |
| `Ctrl + 0` | Reset Font Size |

### YASB (Status Bar)

| Action | Shortcut |
| :--- | :--- |
| Toggle Monocle | Middle-click layout widget |
| Toggle Float | Right-click layout widget |
| Layout Menu | Right-click on layout icon |
| Toggle Microphone | `Alt + Backspace` |

### System

| Shortcut | Action |
| :--- | :--- |
| `Win + Alt + Backspace` | Toggle Microphone Mute |
| Tray Menu | Right-click YASB tray icon |

---

<p align="center">
  Built with passion for those who hate using a mouse. 🐭🚫
</p>