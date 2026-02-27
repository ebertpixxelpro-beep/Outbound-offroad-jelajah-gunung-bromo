$files = Get-ChildItem -Filter "blog-*.html"

$extra_text3 = @"
                    <h2>Dokumentasi dan Mengabadikan Momen</h2>
                    <p>Setelah bersusah payah bangun dini hari dan menembus udara Bromo yang membeku, tidak ada yang lebih penting dari pada mengabadikan momen epic tersebut. Bawa perangkat fotografi terbaik yang Anda miliki, baik itu kamera mirrorless, DSLR, atau sekadar smartphone flagship keluaran terbaru. Jangan lupa untuk memastikan baterai dalam keadaan terisi penuh (100%) dan membawa powerbank cadangan, karena suhu dingin sering kali membuat baterai gawai Anda menurun atau drop lebih cepat dari biasanya.</p>
                    <p>Selain mengandalkan perangkat sendiri, kami di Outbound Offroad Jelajah Bromo juga menyediakan pengemudi Jeep yang sudah dibekali dengan kemampuan dasar fotografi. Para driver lokal ini tidak hanya hafal medan di mana ban mobil harus berbelok, tapi juga sangat paham sudut-sudut rahasia alias <em>secret spots</em> mana saja yang menghasilkan foto berlatar Gunung Widodaren atau lekuk Bukit Teletubbies yang epik. Jangan ragu untuk meminta tolong driver kami mengambil gambar konvoi kendaraan Jeep Anda atau memotret kemesraan bersama keluarga berlatarkan Golden Sunrise.</p>
                    <p>Akhir kata, perhatikan ruang penyimpanan (memory storage) pada kamera atau ponsel Anda. Banyak wisatawan yang kehilangan momen berharga di kawah pasir hanya karena memori penyimpanan penuh di awal perjalanan. Selalu gunakan resolusi terbaik namun dengan alokasi yang cerdas. Bromo selalu menyimpan kejutan visual luar biasa setiap menitnya, dari semburat merah mentari pagi hingga birunya langit benderang di siang hari memayungi lautan padang pasir berbisik.</p>
"@

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        
    if (-not $content.Contains('<h2>Dokumentasi dan Mengabadikan Momen</h2>')) {
        $content = $content.Replace('</article>', $extra_text3 + "`r`n                </article>")
    }
    
    [IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}

Write-Host "Penambahan teks dokumentasi selesai pada $($files.Count) halaman blog."
