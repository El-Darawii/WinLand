# <h1 align="center">Windows Dotfiles 🚀</h1>

<p align="center">
  A professional setup for a tiling window manager environment on Windows.
  <br />
  Featuring <b>WezTerm</b>, <b>Komorebi</b>, <b>AutoHotkey</b>, and <b>YASB</b>.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/OS-Windows-blue?style=flat-square&logo=windows" alt="Windows" />
  <img src="https://img.shields.io/badge/Shell-PowerShell-blue?style=flat-square&logo=powershell" alt="PowerShell" />
  <img src="https://img.shields.io/badge/Config-Lua%20%7C%20YAML%20%7C%20JSON-informational?style=flat-square" alt="Config" />
</p>

---

## 📦 What's Included?

- **[WezTerm](https://wezfurlong.org/wezterm/):** GPU-accelerated cross-platform terminal emulator.
- **[Komorebi](https://github.com/LGUG2Z/komorebi):** A tiling window manager for Windows.
- **[AutoHotkey](https://www.autohotkey.com/):** Scripting language for keyboard shortcuts and automation.
- **[YASB](https://github.com/denBot/yasb):** Yet Another Status Bar for Windows.

## 🚀 Installation

### 1. Prerequisites
Ensure you have **PowerShell 7+** (recommended) and run it as an **Administrator**.

### 2. Clone the Repository
```powershell
git clone https://github.com/YOUR_USERNAME/dotfiles.git $HOME\dotfiles
cd $HOME\dotfiles
```

### 3. Run the Installation Script
The `install.ps1` script will install all necessary tools via **Scoop** and **Winget**, then symlink your configurations.

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
.\scripts\install.ps1
```

## 🛠️ Configuration Details

- **WezTerm:** Configured via `.wezterm.lua` (supports themes, ligatures, and multiplexing).
- **Komorebi:** Managed via `komorebi.json` and `komorebi.ahk` for hotkeys.
- **YASB:** A sleek status bar styled with CSS (`styles.css`) and configured via `config.yaml`.
- **AutoHotkey:** Custom scripts for window management and utility functions.

## 📁 Structure

```text
dotfiles/
├── config/
│   ├── wezterm/      # Terminal configuration
│   ├── komorebi/     # Tiling manager settings
│   ├── yasb/         # Status bar configuration
│   └── ahk/          # Custom AHK scripts
├── scripts/
│   └── install.ps1   # Main deployment script
└── README.md         # This guide
```

## ⚡ Keybindings

*Most keybindings are managed through `komorebi.ahk` (AutoHotkey).*

| Shortcut | Action |
| :--- | :--- |
| `Alt + Enter` | Open Terminal (WezTerm) |
| `Alt + Shift + Q` | Close Window |
| `Alt + [H,J,K,L]` | Focus Window (Left, Down, Up, Right) |
| `Alt + Shift + [H,J,K,L]` | Move Window |
| `Alt + [1-9]` | Switch Workspace |

---

<p align="center">
  Crafted with ❤️ for a better Windows experience.
</p>
