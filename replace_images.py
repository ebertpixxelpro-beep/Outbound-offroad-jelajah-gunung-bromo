import os
import glob
import re

images = [f"assets/img/Slide{i}.JPG" for i in range(45, 55)]
img_idx = 0

def get_next_img():
    global img_idx
    img = images[img_idx % len(images)]
    img_idx += 1
    return img

def repl_src(match):
    src = match.group(1)
    # Check if the image source should be replaced
    if 'unsplash.com' in src or 'hero.png' in src or 'about.png' in src:
        return f'src="{get_next_img()}"'
    return match.group(0)

def repl_meta_img(match):
    content_attr = match.group(1)
    if 'unsplash.com' in content_attr or 'hero.png' in content_attr or 'about.png' in content_attr:
        return f'content="https://jelajah-gunung-bromo.id/{get_next_img()}"'
    return match.group(0)


# Scan all HTML files
html_files = glob.glob("*.html")
for f in html_files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Replace normal <img src="...">
    content = re.sub(r'src="([^"]+)"', repl_src, content)
    
    # Replace meta og:image content="..."
    content = re.sub(r'content="([^"]+)"', repl_meta_img, content)
    
    # For JSON-LD Schema
    content = content.replace('"https://jelajah-gunung-bromo.id/assets/img/hero.png"', f'"https://jelajah-gunung-bromo.id/{images[0]}"')
    content = re.sub(r'"https://images.unsplash.com[^"]+"', f'"https://jelajah-gunung-bromo.id/{images[1]}"', content)
    
    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)

# Process CSS file
css_path = 'assets/css/style.css'
if os.path.exists(css_path):
    with open(css_path, 'r', encoding='utf-8') as file:
        css_content = file.read()
    
    css_content = css_content.replace("url('../img/hero.png')", f"url('../img/Slide45.JPG')")
    css_content = css_content.replace("url('../img/about.png')", f"url('../img/Slide46.JPG')")
    
    with open(css_path, 'w', encoding='utf-8') as file:
        file.write(css_content)

print(f"Updated images in {len(html_files)} HTML files and 1 CSS file.")
