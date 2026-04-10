-- ============================================================
--  WezTerm Configuration
--  Tmux-compatible keybindings + WSL default
--  Place at: C:\Users\<you>\.wezterm.lua  OR
--             C:\Users\<you>\.config\wezterm\wezterm.lua
-- ============================================================

local wezterm = require("wezterm")
local act     = wezterm.action
local config  = wezterm.config_builder()

-- ────────────────────────────────────────────────────────────
-- LEADER  (mirrors tmux prefix)
--   Ctrl+Space  →  primary   (250 ms timeout)
--   Ctrl+B      →  secondary (held simultaneously, or use LEADER)
-- ────────────────────────────────────────────────────────────
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 250 }

-- ────────────────────────────────────────────────────────────
-- DEFAULT PROGRAM  →  WSL (your default distro)
-- ────────────────────────────────────────────────────────────
config.default_prog = {"powershell.exe", "-NoLogo"}

-- ────────────────────────────────────────────────────────────
-- APPEARANCE
-- ────────────────────────────────────────────────────────────
config.color_scheme = "Tokyo Night"   -- dark, clean, great contrast

config.font = wezterm.font_with_fallback({
  { family = "JetBrains Mono", weight = "Regular" },
  { family = "Cascadia Code",  weight = "Regular" },
  { family = "Fira Code",      weight = "Regular" },
  "Noto Color Emoji",
})
config.font_size            = 13.0
config.line_height          = 1.2
config.cell_width           = 1.0
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

-- Window chrome
config.window_decorations         = "RESIZE"          -- borderless but resizable
config.window_background_opacity  = 0.94
config.macos_window_background_blur = 20              -- no-op on Windows, harmless
config.text_background_opacity    = 1.0

config.window_padding = {
  left   = 14,
  right  = 14,
  top    = 10,
  bottom = 6,
}

-- Tab bar
config.enable_tab_bar                  = true
config.use_fancy_tab_bar               = false          -- retro/clean text tab bar
config.tab_bar_at_bottom               = true
config.hide_tab_bar_if_only_one_tab    = false
config.show_tab_index_in_tab_bar       = true
config.tab_max_width                   = 32

config.colors = {
  tab_bar = {
    background        = "#1a1b26",
    active_tab        = { bg_color = "#7aa2f7", fg_color = "#1a1b26", intensity = "Bold" },
    inactive_tab      = { bg_color = "#1a1b26", fg_color = "#565f89" },
    inactive_tab_hover= { bg_color = "#24283b", fg_color = "#a9b1d6" },
    new_tab           = { bg_color = "#1a1b26", fg_color = "#565f89" },
    new_tab_hover     = { bg_color = "#24283b", fg_color = "#7aa2f7" },
  },
}

-- Cursor
config.default_cursor_style        = "BlinkingBar"
config.cursor_blink_rate           = 500
config.cursor_blink_ease_in        = "Constant"
config.cursor_blink_ease_out       = "Constant"

-- Scrollback
config.scrollback_lines            = 10000
config.enable_scroll_bar           = false

-- Bell
config.audible_bell                = "Disabled"
config.visual_bell = {
  fade_in_duration_ms  = 75,
  fade_out_duration_ms = 75,
  target               = "CursorColor",
}

-- ────────────────────────────────────────────────────────────
-- KEYBINDINGS
-- ────────────────────────────────────────────────────────────
config.keys = {

  -- ── Panes ──────────────────────────────────────────────
  -- Prefix + v  →  Split right (vertical split = side-by-side)
  {
    key = "v", mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  -- Prefix + h  →  Split below (horizontal split = top/bottom)
  {
    key = "h", mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  -- Prefix + x  →  Kill pane (with confirmation)
  {
    key = "x", mods = "LEADER",
    action = act.CloseCurrentPane({ confirm = false }),
  },
  -- Prefix + z  →  Toggle pane zoom (fullscreen pane)
  {
    key = "z", mods = "LEADER",
    action = act.TogglePaneZoomState,
  },

  -- Ctrl+Alt+Arrows  →  Move between panes
  { key = "LeftArrow",  mods = "CTRL|ALT", action = act.ActivatePaneDirection("Left")  },
  { key = "RightArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow",    mods = "CTRL|ALT", action = act.ActivatePaneDirection("Up")    },
  { key = "DownArrow",  mods = "CTRL|ALT", action = act.ActivatePaneDirection("Down")  },

  -- Ctrl+Alt+Shift+Arrows  →  Resize panes
  { key = "LeftArrow",  mods = "CTRL|ALT|SHIFT", action = act.AdjustPaneSize({ "Left",  5 }) },
  { key = "RightArrow", mods = "CTRL|ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
  { key = "UpArrow",    mods = "CTRL|ALT|SHIFT", action = act.AdjustPaneSize({ "Up",    3 }) },
  { key = "DownArrow",  mods = "CTRL|ALT|SHIFT", action = act.AdjustPaneSize({ "Down",  3 }) },

  -- ── Windows (Tabs) ─────────────────────────────────────
  -- Prefix + c  →  New window/tab
  {
    key = "c", mods = "LEADER",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  -- Prefix + k  →  Kill window/tab
  {
    key = "k", mods = "LEADER",
    action = act.CloseCurrentTab({ confirm = false }),
  },
  -- Prefix + r  →  Rename window/tab
  {
    key = "r", mods = "LEADER",
    action = act.PromptInputLine({
      description = "Rename tab:",
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
    }),
  },
  -- Alt+1-9  →  Go to specific tab
  { key = "1", mods = "ALT", action = act.ActivateTab(0) },
  { key = "2", mods = "ALT", action = act.ActivateTab(1) },
  { key = "3", mods = "ALT", action = act.ActivateTab(2) },
  { key = "4", mods = "ALT", action = act.ActivateTab(3) },
  { key = "5", mods = "ALT", action = act.ActivateTab(4) },
  { key = "6", mods = "ALT", action = act.ActivateTab(5) },
  { key = "7", mods = "ALT", action = act.ActivateTab(6) },
  { key = "8", mods = "ALT", action = act.ActivateTab(7) },
  { key = "9", mods = "ALT", action = act.ActivateTab(8) },
  -- Alt+Left/Right  →  Move between tabs
  { key = "LeftArrow",  mods = "ALT", action = act.ActivateTabRelative(-1) },
  { key = "RightArrow", mods = "ALT", action = act.ActivateTabRelative(1)  },

  -- ── Sessions (Workspaces) ──────────────────────────────
  -- Prefix + C  →  New workspace/session
  {
    key = "C", mods = "LEADER",
    action = act.PromptInputLine({
      description = "New workspace name:",
      action = wezterm.action_callback(function(window, pane, line)
        if line and line ~= "" then
          window:perform_action(
            act.SwitchToWorkspace({ name = line }),
            pane
          )
        end
      end),
    }),
  },
  -- Prefix + K  →  Kill (close) current workspace
  -- WezTerm doesn't have a direct "kill workspace" action; we close all tabs instead.
  {
    key = "K", mods = "LEADER",
    action = wezterm.action_callback(function(window, _)
      -- Close all tabs in the current workspace by closing the window
      window:close()
    end),
  },
  -- Prefix + R  →  Rename workspace
  {
    key = "R", mods = "LEADER",
    action = act.PromptInputLine({
      description = "Rename workspace:",
      action = wezterm.action_callback(function(window, pane, line)
        if line and line ~= "" then
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    }),
  },
  -- Prefix + N  →  Next workspace
  { key = "N", mods = "LEADER", action = act.SwitchWorkspaceRelative(1)  },
  -- Prefix + P  →  Previous workspace
  { key = "P", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },
  -- Alt+Up/Down  →  Move between workspaces
  { key = "UpArrow",   mods = "ALT", action = act.SwitchWorkspaceRelative(-1) },
  { key = "DownArrow", mods = "ALT", action = act.SwitchWorkspaceRelative(1)  },
  -- Prefix + s  →  Show workspace switcher
  {
    key = "s", mods = "LEADER",
    action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
  },
  -- Prefix + d  →  "Detach" — hide WezTerm (closest equivalent on Windows)
  {
    key = "d", mods = "LEADER",
    action = wezterm.action_callback(function(window, _)
      window:minimize()
    end),
  },

  -- ── Copy mode (vi-style) ───────────────────────────────
  -- Prefix + [  →  Enter copy mode
  {
    key = "[", mods = "LEADER",
    action = act.ActivateCopyMode,
  },

  -- ── General ────────────────────────────────────────────
  -- Prefix + q  →  Reload config
  {
    key = "q", mods = "LEADER",
    action = act.ReloadConfiguration,
  },
  -- Prefix + :  →  WezTerm command palette (closest to tmux command prompt)
  {
    key = ":", mods = "LEADER",
    action = act.ActivateCommandPalette,
  },

  -- ── Ctrl+B as alternate leader (manual bindings) ───────
  -- Since WezTerm only supports one LEADER, we replicate the most-used
  -- bindings under Ctrl+B as direct shortcuts.
  { key = "v", mods = "CTRL|SHIFT|ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "CTRL|SHIFT|ALT", action = act.SplitVertical({   domain = "CurrentPaneDomain" }) },

  -- ── Clipboard ──────────────────────────────────────────
  { key = "C", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard")  },
  { key = "V", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

  -- ── Font size ──────────────────────────────────────────
  { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
  { key = "0", mods = "CTRL", action = act.ResetFontSize    },
}

-- ────────────────────────────────────────────────────────────
-- COPY MODE  (vi-style)
-- ────────────────────────────────────────────────────────────
config.key_tables = {
  copy_mode = {
    -- Navigation
    { key = "h",          mods = "NONE", action = act.CopyMode("MoveLeft")              },
    { key = "j",          mods = "NONE", action = act.CopyMode("MoveDown")              },
    { key = "k",          mods = "NONE", action = act.CopyMode("MoveUp")                },
    { key = "l",          mods = "NONE", action = act.CopyMode("MoveRight")             },
    { key = "w",          mods = "NONE", action = act.CopyMode("MoveForwardWord")       },
    { key = "b",          mods = "NONE", action = act.CopyMode("MoveBackwardWord")      },
    { key = "0",          mods = "NONE", action = act.CopyMode("MoveToStartOfLine")     },
    { key = "$",          mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent")},
    { key = "g",          mods = "NONE", action = act.CopyMode("MoveToScrollbackTop")   },
    { key = "G",          mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom")},
    { key = "PageUp",     mods = "NONE", action = act.CopyMode("PageUp")                },
    { key = "PageDown",   mods = "NONE", action = act.CopyMode("PageDown")              },
    -- Selection  (v → begin,  y → yank)
    {
      key = "v", mods = "NONE",
      action = act.CopyMode({ SetSelectionMode = "Cell" }),
    },
    {
      key = "V", mods = "NONE",
      action = act.CopyMode({ SetSelectionMode = "Line" }),
    },
    {
      key = "y", mods = "NONE",
      action = act.Multiple({
        act.CopyTo("ClipboardAndPrimarySelection"),
        act.CopyMode("Close"),
      }),
    },
    -- Exit
    { key = "q",      mods = "NONE", action = act.CopyMode("Close") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
  },
}

-- ────────────────────────────────────────────────────────────
-- STATUS BAR  (right side — shows workspace + datetime)
-- ────────────────────────────────────────────────────────────
wezterm.on("update-right-status", function(window, _)
  local workspace = window:active_workspace()
  local date      = wezterm.strftime(" %a %d %b  %H:%M")
  local leader    = window:leader_is_active() and wezterm.format({
    { Foreground = { Color = "#f7768e" } },
    { Text = "  ⌨  WAIT " },
  }) or ""

  window:set_right_status(wezterm.format({
    { Foreground = { Color = "#565f89" } }, { Text = "  " },
    { Foreground = { Color = "#7aa2f7" } }, { Text = "󱂬 " .. workspace },
    { Foreground = { Color = "#565f89" } }, { Text = "  │  " },
    { Foreground = { Color = "#9ece6a" } }, { Text = date },
    { Foreground = { Color = "#565f89" } }, { Text = "  " },
  }) .. leader)
end)

-- ────────────────────────────────────────────────────────────
-- MISC
-- ────────────────────────────────────────────────────────────
config.check_for_updates               = false
config.warn_about_missing_glyphs       = false
config.automatically_reload_config     = true
config.exit_behavior                   = "Close"
config.window_close_confirmation       = "NeverPrompt"
config.skip_close_confirmation_for_processes_named = {
  "bash", "sh", "zsh", "fish", "tmux", "powershell", "pwsh",
}

-- ────────────────────────────────────────────────────────────
-- MOUSE
-- ────────────────────────────────────────────────────────────
config.mouse_bindings = {
  -- Right-click paste
  {
    event  = { Down = { streak = 1, button = "Right" } },
    mods   = "NONE",
    action = act.PasteFrom("Clipboard"),
  },
}

return config