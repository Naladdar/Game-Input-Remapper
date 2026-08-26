# Game Input Remapper v1.0.0
# Bootstrap loader for the compressed application payload.
# Windows PowerShell 5.1 / Windows 10/11

$ErrorActionPreference = 'Stop'

$payloadPath = Join-Path $PSScriptRoot 'GameInputRemapper.payload'
if (-not (Test-Path -LiteralPath $payloadPath)) {
    throw "GameInputRemapper.payload was not found next to GameInputRemapper.ps1."
}

$payload = [System.IO.File]::ReadAllText($payloadPath).Trim()
$compressedBytes = [Convert]::FromBase64String($payload)
$memoryStream = [System.IO.MemoryStream]::new($compressedBytes)
$gzipStream = [System.IO.Compression.GZipStream]::new(
    $memoryStream,
    [System.IO.Compression.CompressionMode]::Decompress
)
$reader = [System.IO.StreamReader]::new(
    $gzipStream,
    [System.Text.Encoding]::UTF8,
    $true
)

try {
    $source = $reader.ReadToEnd()
}
finally {
    $reader.Dispose()
    $gzipStream.Dispose()
    $memoryStream.Dispose()
}

Invoke-Expression $source
