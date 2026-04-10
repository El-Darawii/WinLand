# Toggle microphone mute script
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class AudioControl {
    [DllImport("winmm.dll")]
    public static extern int waveInGetNumDevs();
    
    [DllImport("winmm.dll")]
    public static extern int mixerGetNumDevs();
}
"@

# Use NirCmd if available, otherwise use built-in Windows commands
$nircmd = Get-Command nircmd -ErrorAction SilentlyContinue

if ($nircmd) {
    # Use NirCmd for reliable mic toggle
    Start-Process -FilePath "nircmd.exe" -ArgumentList "mutesysvolume", "2" -WindowStyle Hidden
} else {
    # Fallback: Use PowerShell to toggle mic
    $devices = Get-AudioDevice -List | Where-Object { $_.Type -eq "Recording" -and $_.Default -eq $true }
    if ($devices) {
        $currentMute = $devices[0].Mute
        Set-AudioDevice -Index $devices[0].Index -Mute (!$currentMute)
    }
}
