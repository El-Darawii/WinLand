$ahkExe = "C:\Users\pc\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe"
$ahkScript = "C:\Users\pc\.config\komorebi\komorebi.ahk"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "KomorebiSession" -Value "`"$ahkExe`" `"$ahkScript`""
Write-Host "Registry entry created"
