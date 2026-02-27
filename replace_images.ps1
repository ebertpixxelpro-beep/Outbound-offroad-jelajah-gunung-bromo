$htmlFiles = Get-ChildItem -Filter "*.html"
$cssFile = "assets\css\style.css"

$images = @(45..54 | ForEach-Object { "assets/img/Slide$_.JPG" })
$imgIdx = 0

function Get-NextImage {
    $img = $images[$script:imgIdx % $images.Length]
    $script:imgIdx++
    return $img
}

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Replace normal <img src="..."> matched by regex
    $content = [regex]::Replace($content, 'src="([^"]+)"', {
        param($match)
        $src = $match.Groups[1].Value
        if ($src -match 'unsplash\.com' -or $src -match 'hero\.png' -or $src -match 'about\.png') {
            return "src=`"$(Get-NextImage)`""
        }
        return $match.Value
    })
    
    # Replace meta og:image content="..."
    $content = [regex]::Replace($content, 'content="([^"]+)"', {
        param($match)
        $contentAttr = $match.Groups[1].Value
        if ($contentAttr -match 'unsplash\.com' -or $contentAttr -match 'hero\.png' -or $contentAttr -match 'about\.png') {
            return "content=`"https://jelajah-gunung-bromo.id/$(Get-NextImage)`""
        }
        return $match.Value
    })
    
    # Handle direct replacements for JSON-LD arrays if any
    $nextImgFromList = $images[0]
    $content = $content.Replace('"https://jelajah-gunung-bromo.id/assets/img/hero.png"', "`"https://jelajah-gunung-bromo.id/$nextImgFromList`"")
    
    $content = [regex]::Replace($content, '"https://images\.unsplash\.com[^"]+"', '"https://jelajah-gunung-bromo.id/assets/img/Slide46.JPG"')
    
    [IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}

if (Test-Path $cssFile) {
    $cssContent = Get-Content -Path $cssFile -Raw -Encoding UTF8
    $cssContent = $cssContent.Replace("url('../img/hero.png')", "url('../img/Slide45.JPG')")
    $cssContent = $cssContent.Replace("url('../img/about.png')", "url('../img/Slide46.JPG')")
    [IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)
}

Write-Host "Updated images in html files and css."
