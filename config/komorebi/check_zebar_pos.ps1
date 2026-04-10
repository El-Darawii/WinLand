Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class Win32 {
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
    [StructLayout(LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }
}
"@

$p = Get-Process zebar -ErrorAction SilentlyContinue | Select-Object -First 1
if ($p) {
    $r = New-Object Win32+RECT
    [Win32]::GetWindowRect($p.MainWindowHandle, [ref]$r) | Out-Null
    Write-Host "Window Position: Left=$($r.Left), Top=$($r.Top), Right=$($r.Right), Bottom=$($r.Bottom)"
    Write-Host "Height: $($r.Bottom - $r.Top), Width: $($r.Right - $r.Left)"
} else {
    Write-Host "Zebar not running"
}
