# Reconstruct the full readable v1.0.0 application source from GameInputRemapper.payload.
$ErrorActionPreference = 'Stop'

$payloadPath = Join-Path $PSScriptRoot 'GameInputRemapper.payload'
$outPath = Join-Path $PSScriptRoot 'GameInputRemapper.full.ps1'

$payload = [System.IO.File]::ReadAllText($payloadPath).Trim()
$compressedBytes = [Convert]::FromBase64String($payload)
$memoryStream = [System.IO.MemoryStream]::new($compressedBytes)
$gzipStream = [System.IO.Compression.GZipStream]::new($memoryStream,[System.IO.Compression.CompressionMode]::Decompress)
$reader = [System.IO.StreamReader]::new($gzipStream,[System.Text.Encoding]::UTF8,$true)

try {
    $source = $reader.ReadToEnd()
}
finally {
    $reader.Dispose()
    $gzipStream.Dispose()
    $memoryStream.Dispose()
}

$utf8Bom = [System.Text.UTF8Encoding]::new($true)
[System.IO.File]::WriteAllText($outPath,$source,$utf8Bom)
Write-Host "Created: $outPath"
