$htmlFiles = Get-ChildItem -Filter "*.html"
$images = @(45..54 | ForEach-Object { "assets/img/Slide$_.JPG" })
$script:imgIdx = 0

function Get-NextImage {
    $img = $images[$script:imgIdx % $images.Length]
    $script:imgIdx++
    return $img
}

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # src="..."
    $content = [regex]::Replace($content, 'src="([^"]+)"', {
        param($match)
        $src = $match.Groups[1].Value
        if ($src -match '\.(png|jpg|jpeg|gif|webp|JPG)(\?.*)?$' -and $src -notmatch 'favicon') {
            return "src=`"$(Get-NextImage)`""
        }
        return $match.Value
    })
    
    # content="..." (for og:image or twitter:image)
    $content = [regex]::Replace($content, 'content="([^"]+)"', {
        param($match)
        $cAttr = $match.Groups[1].Value
        if ($cAttr -match '\.(png|jpg|jpeg|gif|webp|JPG)(\?.*)?$' -and $cAttr -notmatch 'favicon') {
            return "content=`"https://jelajah-gunung-bromo.id/$(Get-NextImage)`""
        }
        return $match.Value
    })

    # "url" in JSON block
    $content = [regex]::Replace($content, '"(https?://[^"]+\.(?:png|jpg|jpeg|gif|webp|JPG)(?:\?.*)?)"', {
        param($match)
        $urlMatches = $match.Groups[1].Value
        if ($urlMatches -notmatch 'favicon') {
            return "`"https://jelajah-gunung-bromo.id/$(Get-NextImage)`""
        }
        return $match.Value
    })

    [IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}

$cssFile = "assets\css\style.css"
if (Test-Path $cssFile) {
    $cssContent = Get-Content -Path $cssFile -Raw -Encoding UTF8
    $cssContent = [regex]::Replace($cssContent, "url\(['`"']?([^'`"\)]+)['`"']?\)", {
        param($match)
        $urlAttr = $match.Groups[1].Value
        if ($urlAttr -match '\.(png|jpg|jpeg|gif|webp|JPG)(\?.*)?$') {
            $nImg = (Get-NextImage) -replace 'assets/img/', ''
            return "url('../img/$nImg')"
        }
        return $match.Value
    })
    [IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)
}

Write-Host "Images successfully distributed across all files."
