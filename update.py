import os
import glob

files = glob.glob('blog-*.html')

extra_text = """
                    <h2>Mengapa Memilih Layanan Kami?</h2>
                    <p>Merencanakan liburan ke Gunung Bromo mungkin terdengar menantang karena medannya yang cukup ekstrem dan cuaca yang tidak menentu. Oleh karena itu, percayakan perjalanan Anda bersama tim <strong>Outbound Offroad Jelajah Gunung Bromo</strong>. Kami tidak sekadar memberikan layanan antar-jemput, tetapi menawarkan pengalaman wisata premium yang utuh. Mulai dari penjemputan di hotel, stasiun, maupun bandara, armada Jeep Hardtop klasik yang bersih dan full AC, hingga pengemudi lokal berpengalaman yang sangat ramah dan merangkap sebagai fotografer pribadi Anda.</p>
                    <p>Selain itu, seluruh paket tur kami sangat fleksibel dan dapat diatur sesuai dengan kebutuhan keluarga, rombongan perusahaan (corporate gathering), maupun pasangan yang sedang bulan madu. Dengan memilih spesialis Jeep perintis, Anda secara langsung mendukung roda pariwisata masyarakat lokal sambil tetap menikmati kenyamanan fasilitas VIP. Segera rencanakan cuti Anda, siapkan fisik terbaik, dan biarkan kami mengatur semua detail teknis perjalanan Anda di hamparan gunung terindah di Pulau Jawa ini.</p>
"""

for file in files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1. Navbar brand
    content = content.replace('<i class="fas fa-mountain"></i> BromoOffroad', '<i class="fas fa-mountain"></i> Outbound')
    content = content.replace('<i class="fas fa-mountain text-primary"></i> Bromo Offroad Jelajah', '<i class="fas fa-mountain text-primary"></i> Outbound Offroad Jelajah')
    
    # 2. Footer copyright
    content = content.replace('&copy; 2026 Outbound Offroad Bromo Tour. All Rights Reserved.', 'karya website: Adiel Ebert Nakula Shandy')
    
    # 3. Add more text before </article>
    if '<h2>Mengapa Memilih Layanan Kami?</h2>' not in content:
        content = content.replace('</article>', extra_text + '\n                </article>')
    
    with open(file, 'w', encoding='utf-8') as f:
        f.write(content)

print(f"Updated {len(files)} blog files.")
