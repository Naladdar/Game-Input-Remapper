# Reconstruct the full readable v1.0.0 application source.
$ErrorActionPreference = 'Stop'

$partPaths = 1..4 | ForEach-Object {
    Join-Path $PSScriptRoot ("GameInputRemapper.payload.{0:D2}" -f $_)
}
$outPath = Join-Path $PSScriptRoot 'GameInputRemapper.full.ps1'

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

$utf8Bom = [System.Text.UTF8Encoding]::new($true)
[System.IO.File]::WriteAllText($outPath, $source, $utf8Bom)
Write-Host "Created: $outPath"
