$files = Get-ChildItem -Filter "blog-*.html"

$extra_text2 = @"
                    <h2>Persiapan Fisik dan Mental Sebelum Ke Bromo</h2>
                    <p>Selain persiapan perlengkapan dan pemilihan penyedia jasa tur yang terpercaya, mempersiapkan kondisi fisik sebelum melakukan pendakian ke kawasan Bromo sangatlah penting. Udara yang sangat dingin ditambah dengan elevasi di titik-titik tertentu, seperti ratusan anak tangga menuju puncak kawah aktif Bromo, mengharuskan Anda memiliki stamina yang cukup prima. Sangat disarankan untuk menyempatkan berolahraga kardio ringan seperti jogging, bersepeda, atau jalan cepat beberapa hari sebelum jadwal keberangkatan Anda.</p>
                    <p>Pastikan juga Anda mendapatkan istirahat dan tidur yang sangat cukup sebelum memulai perjalanan dini hari. Karena sebagian besar tur Bromo akan mulai diberangkatkan dari penginapan atau titik pertemuan pada pukul 00.30 malam, jika Anda kurang tidur, risiko mengalami pusing akut atau mabuk perjalanan di jalanan offroad dalam Jeep akan meningkat secara drastis.</p>
                    <p>Jangan pernah lupa untuk selalu membawa botol air mineral pribadi (tumbler) dan mengonsumsi makanan ringan (snek) yang mengandung karbohidrat maupun gula untuk terus menjaga asupan energi kalori Anda. Tubuh membakar banyak kalori ketika menahan hawa dingin yang menusuk. Dengan persiapan yang sangat matang ini, pengalaman wisata jelajah Bromo Anda akan berubah menjadi kenangan manis dan sangat asyik tanpa harus terkendala kondisi fisik yang tiba-tiba menurun (drop).</p>
"@

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Menghapus blok Promo GIF 1 dan Promo GIF 2 beserta div di bawahnya
    $content = $content -replace '(?s)<!-- Promo GIF \d+ -->\s*<div class="promo-gif">.*?</div>\s*', ''
    # Fallback in case the comment was slightly different
    $content = $content -replace '(?s)<div class="promo-gif">.*?</div>\s*', ''
    
    if (-not $content.Contains('<h2>Persiapan Fisik dan Mental Sebelum Ke Bromo</h2>')) {
        $content = $content.Replace('</article>', $extra_text2 + "`r`n                </article>")
    }
    
    [IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}

Write-Host "Revisi teks panjang dan penghapusan GIF Giphy selesai pada $($files.Count) halaman blog."
