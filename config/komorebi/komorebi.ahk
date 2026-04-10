#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook

SendLevel 1

KOMOREBIC := "komorebic.exe"
ZEBAR_DIR := A_AppData "\scoop\apps\zebar\current\zebar.exe"

kc(cmd) {
    Run "komorebic " cmd, , "Hide"
}

#h:: kc("focus left")
#j:: kc("focus down")
#k:: kc("focus up")
#Left:: kc("focus left")
#Down:: kc("focus down")
#Up:: kc("focus up")
#Right:: kc("focus right")

#+h:: kc("move left")
#+j:: kc("move down")
#+k:: kc("move up")
#+l:: kc("move right")

#+Left:: kc("move left")
#+Down:: kc("move down")
#+Up:: kc("move up")
#+Right:: kc("move right")

#!h:: kc("resize-axis horizontal decrease")
#!j:: kc("resize-axis vertical increase")
#!k:: kc("resize-axis vertical decrease")
#!l:: kc("resize-axis horizontal increase")

#+f:: kc("flip-layout vertical")
#+v:: kc("flip-layout horizontal")

#w:: kc("close")
#f:: kc("toggle-monocle")

#1:: kc("focus-workspace 0")
#2:: kc("focus-workspace 1")
#3:: kc("focus-workspace 2")
#4:: kc("focus-workspace 3")
#5:: kc("focus-workspace 4")
#6:: kc("focus-workspace 5")
#7:: kc("focus-workspace 6")
#8:: kc("focus-workspace 7")
#9:: kc("focus-workspace 8")
#0:: kc("focus-workspace 9")

#+1:: kc("move-to-workspace 0")
#+2:: kc("move-to-workspace 1")
#+3:: kc("move-to-workspace 2")
#+4:: kc("move-to-workspace 3")
#+5:: kc("move-to-workspace 4")
#+6:: kc("move-to-workspace 5")
#+7:: kc("move-to-workspace 6")
#+8:: kc("move-to-workspace 7")
#+9:: kc("move-to-workspace 8")
#+0:: kc("move-to-workspace 9")

#Enter:: Run "C:\Program Files\WezTerm\wezterm-gui.exe"
#n:: Run '"C:\Program Files\Alacritty\alacritty.exe" -e "C:\Program Files\Neovim\bin\nvim.exe"', "C:\Users\pc"
#b:: Run "brave.exe"
#e:: Run "explorer.exe"
#d:: Run "C:\Users\pc\AppData\Local\Discord\app-1.0.9231\Discord.exe"
#+w:: Run "shell:AppsFolder\5319275A.WhatsAppDesktop_cv1g1gvanyjgm!App"
#m:: Run "C:\Users\pc\AppData\Roaming\Spotify\Spotify.exe"
#l:: return

#\:: ToggleLayout()

ToggleLayout() {
    shell := ComObject("WScript.Shell")
    exec := shell.Exec("komorebic.exe query focused-workspace-layout")
    output := exec.StdOut.ReadAll()
    output := Trim(output)
    
    if (InStr(output, "BSP")) {
        kc("change-layout scrolling")
    } else {
        kc("change-layout bsp")
    }
}

#Space:: Send "!{Space}"

#[:: kc("cycle-focus previous")
#]:: kc("cycle-focus next")

^#r:: BootKomorebi()

MenuHandler(ItemName, ItemPos, Menu) {
    if (ItemName = "Reload Script") {
        Reload
    } else if (ItemName = "Restart All (Komorebi/YASB/AHK)") {
        BootKomorebi()
    } else if (ItemName = "Stop komorebi") {
        kc("stop")
    } else if (ItemName = "Toggle Taskbar") {
        kc("toggle-taskbar")
    } else if (ItemName = "Exit") {
        ExitApp
    }
}

TrayMenu := A_TrayMenu
TrayMenu.Delete()
TrayMenu.Add("Reload Script", MenuHandler)
TrayMenu.Add("Reload komorebi", MenuHandler)
TrayMenu.Add("Stop komorebi", MenuHandler)
TrayMenu.Add("Toggle Taskbar", MenuHandler)
TrayMenu.Add()
TrayMenu.Add("Exit", MenuHandler)

BootKomorebi() {
    global KOMOREBIC
    YASB_EXE := "yasb.exe"
    APP_CONFIG := "C:\Users\pc\.config\komorebi\applications.yaml"
    ToolTip "Starting komorebi...", , , 1
    
    Run KOMOREBIC " stop", , "Hide"
    Sleep 500
    Run "taskkill /F /IM yasb.exe", , "Hide"
    Sleep 300
    Run KOMOREBIC " start --await-configuration", , "Hide"
    Sleep 1500
    
    Run KOMOREBIC " window-hiding-behaviour Cloak", , "Hide"
    Sleep 200
    Run KOMOREBIC " hide-taskbar enable", , "Hide"
    Sleep 200
    Run KOMOREBIC " global-work-area-offset 0 80 0 60", , "Hide"
    Sleep 200
    Run KOMOREBIC " mouse-follows-focus enable", , "Hide"
    Sleep 200
    Run KOMOREBIC " focus-follows-mouse enable", , "Hide"
    Sleep 200
    
    Run KOMOREBIC " manage-rule exe SnippingTool.exe disable", , "Hide"
    Run KOMOREBIC " manage-rule exe ScreenClippingHost.exe disable", , "Hide"
    Run KOMOREBIC " manage-rule exe SnippingToolProcess.exe disable", , "Hide"
    Run KOMOREBIC " manage-rule class Msghost disable", , "Hide"
    Run KOMOREBIC " manage-rule exe ShellExperienceHost.exe disable", , "Hide"
    Sleep 200
    
    if FileExist(APP_CONFIG) {
        Run KOMOREBIC " application-specific-configuration " . APP_CONFIG, , "Hide"
        Sleep 500
    }
    
    Run YASB_EXE, , "Hide"
    
    Run KOMOREBIC " complete-configuration", , "Hide"
    
    ToolTip "Komorebi ready!", , , 1
    SetTimer (*) => ToolTip("", , 1), -3000
}

; BootKomorebi()
