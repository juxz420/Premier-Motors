# Skrypt konwersji obrazów do WebP i tworzenia responsywnych rozmiarów
# Używa wbudowanych funkcji .NET - nie wymaga zewnętrznych narzędzi!

param(
    [string]$SourceDir = "images",
    [int]$Quality = 85
)

Write-Host "=== Konwersja obrazów do WebP i tworzenie responsywnych rozmiarów ===" -ForegroundColor Cyan
Write-Host ""

# Dodaj assembly System.Drawing
Add-Type -AssemblyName System.Drawing

# Funkcja do zmiany rozmiaru obrazu
function Resize-Image {
    param(
        [string]$InputPath,
        [string]$OutputPath,
        [int]$MaxSize
    )
    
    try {
        $img = [System.Drawing.Image]::FromFile($InputPath)
        
        $width = $img.Width
        $height = $img.Height
        
        # Oblicz nowe wymiary zachowując proporcje
        if ($width -gt $height) {
            if ($width -gt $MaxSize) {
                $newWidth = $MaxSize
                $newHeight = [int]($height * $MaxSize / $width)
            } else {
                $newWidth = $width
                $newHeight = $height
            }
        } else {
            if ($height -gt $MaxSize) {
                $newHeight = $MaxSize
                $newWidth = [int]($width * $MaxSize / $height)
            } else {
                $newWidth = $width
                $newHeight = $height
            }
        }
        
        # Utwórz nowy obraz
        $newImg = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
        $graphics = [System.Drawing.Graphics]::FromImage($newImg)
        
        # Ustaw wysoką jakość renderowania
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        
        $graphics.DrawImage($img, 0, 0, $newWidth, $newHeight)
        
        # Zapisz jako JPEG
        $encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
        $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, $Quality)
        
        $newImg.Save($OutputPath, $encoder, $encoderParams)
        
        $graphics.Dispose()
        $newImg.Dispose()
        $img.Dispose()
        
        return $true
    }
    catch {
        Write-Host "  Błąd: $_" -ForegroundColor Red
        return $false
    }
}

# Znajdź wszystkie obrazy JPG
$images = Get-ChildItem -Path $SourceDir -Recurse -Include *.jpg,*.JPG,*.jpeg,*.JPEG

Write-Host "Znaleziono $($images.Count) obrazów do przetworzenia" -ForegroundColor Green
Write-Host ""

$processed = 0
$errors = 0

foreach ($file in $images) {
    $base = $file.BaseName
    $dir = $file.DirectoryName
    
    Write-Host "[$($processed + 1)/$($images.Count)] Przetwarzam: $($file.Name)" -ForegroundColor Yellow
    
    # Rozmiary responsywne
    $sizes = @{
        "small" = 640
        "medium" = 1024
        "large" = 1920
    }
    
    foreach ($sizeName in $sizes.Keys) {
        $sizeValue = $sizes[$sizeName]
        $resizedJpg = "$dir\$base-$sizeName.jpg"
        
        if (-not (Test-Path $resizedJpg)) {
            Write-Host "  -> Tworzę: $sizeName (${sizeValue}px)" -ForegroundColor Gray
            $success = Resize-Image -InputPath $file.FullName -OutputPath $resizedJpg -MaxSize $sizeValue
            if ($success) {
                $processed++
            } else {
                $errors++
            }
        } else {
            Write-Host "  -> Pomijam: $sizeName (już istnieje)" -ForegroundColor DarkGray
        }
    }
}

Write-Host ""
Write-Host "=== Konwersja zakonczona ===" -ForegroundColor Cyan
Write-Host "Przetworzono: $processed obrazow" -ForegroundColor Green
if ($errors -gt 0) {
    Write-Host "Bledy: $errors" -ForegroundColor Red
}
Write-Host ""
Write-Host "UWAGA: WebP nie jest wspierany przez .NET Framework w PowerShell 5.1" -ForegroundColor Yellow
Write-Host "Utworzono responsywne rozmiary JPG (small, medium, large)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Jesli chcesz WebP, mozesz:" -ForegroundColor Cyan
Write-Host "1. Uzyc online converter: https://cloudconvert.com/jpg-to-webp" -ForegroundColor White
Write-Host "2. Zainstalowac ImageMagick: https://imagemagick.org/script/download.php" -ForegroundColor White
Write-Host "3. Uzyc Netlify - automatycznie konwertuje do WebP przy deploy" -ForegroundColor White
