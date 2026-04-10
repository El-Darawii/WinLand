Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class Win32 {
    [DllImport("user32.dll", CharSet = CharSet.Auto)] public static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);
}
"@

$snip = Get-Process SnippingTool -ErrorAction SilentlyContinue | Select-Object -First 1
if ($snip) {
    $hwnd = $snip.MainWindowHandle
    $sb = New-Object System.Text.StringBuilder 256
    [Win32]::GetClassName($hwnd, $sb, 256) | Out-Null
    Write-Host "SnippingTool Class: $($sb.ToString())"
}
