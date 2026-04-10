Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class Win32 {
    [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll", CharSet = CharSet.Auto)] public static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);
}
"@

$zebar = Get-Process zebar -ErrorAction SilentlyContinue | Select-Object -First 1
if ($zebar) {
    $hwnd = $zebar.MainWindowHandle
    $sb = New-Object System.Text.StringBuilder 256
    [Win32]::GetClassName($hwnd, $sb, 256) | Out-Null
    Write-Host "Class: $($sb.ToString())"
    Write-Host "Title: $($zebar.MainWindowTitle)"
}
