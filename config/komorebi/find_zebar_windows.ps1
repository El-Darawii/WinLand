Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class Win32 {
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);
    public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);
    [DllImport("user32.dll")] public static extern int GetWindowTextLength(IntPtr hWnd);
    [DllImport("user32.dll", CharSet = CharSet.Auto)] public static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);
    [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
}
"@

$zebarProc = Get-Process zebar -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $zebarProc) {
    Write-Host "Zebar not running"
    exit
}

$zebarPid = $zebarProc.Id
Write-Host "Zebar PID: $zebarPid"

$callback = [Win32+EnumWindowsProc]{
    param($hWnd, $lParam)
    $pid = 0
    [Win32]::GetWindowThreadProcessId($hWnd, [ref]$pid) | Out-Null
    if ($pid -eq $zebarPid) {
        $len = [Win32]::GetWindowTextLength($hWnd)
        $title = ""
        if ($len -gt 0) {
            $sb = New-Object System.Text.StringBuilder ($len + 1)
            [Win32]::GetWindowText($hWnd, $sb, $sb.Capacity) | Out-Null
            $title = $sb.ToString()
        }
        $cls = New-Object System.Text.StringBuilder 256
        [Win32]::GetClassName($hWnd, $cls, 256) | Out-Null
        $className = $cls.ToString()
        Write-Host "Title: '$title' | Class: '$className'"
    }
    return $true
}
[Win32]::EnumWindows($callback, [IntPtr]::Zero) | Out-Null
