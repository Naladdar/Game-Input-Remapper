# Game Input Remapper v1.0.0
# Windows PowerShell 5.1 / Windows 10/11

$ErrorActionPreference = 'Stop'

$partPaths = 1..4 | ForEach-Object {
    Join-Path $PSScriptRoot ("GameInputRemapper.payload.{0:D2}" -f $_)
}

foreach ($path in $partPaths) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Missing application payload part: $path"
    }
}

$payload = ($partPaths | ForEach-Object {
    [System.IO.File]::ReadAllText($_).Trim()
}) -join ''

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
