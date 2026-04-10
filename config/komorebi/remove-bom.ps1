$bom = [byte[]](0xEF, 0xBB, 0xBF)
$files = @(
    "C:\Users\pc\.config\komorebi\komorebi.json",
    "C:\Users\pc\.config\komorebi\applications.yaml"
)
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllBytes($file)
    if ($content[0] -eq 0xEF -and $content[1] -eq 0xBB -and $content[2] -eq 0xBF) {
        Write-Host "Removing BOM from $file"
        $content = $content[3..($content.Length-1)]
        [System.IO.File]::WriteAllBytes($file, $content)
    }
}
