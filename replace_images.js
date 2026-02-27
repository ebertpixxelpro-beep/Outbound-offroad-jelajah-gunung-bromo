const fs = require('fs');
const path = require('path');

const dir = process.cwd();
const images = Array.from({ length: 10 }, (_, i) => `assets/img/Slide${45 + i}.JPG`);
let imgIdx = 0;

function getNextImage() {
    const img = images[imgIdx % images.length];
    imgIdx++;
    return img;
}

const htmlFiles = fs.readdirSync(dir).filter(f => f.endsWith('.html'));

for (const file of htmlFiles) {
    const filePath = path.join(dir, file);
    let content = fs.readFileSync(filePath, 'utf8');

    // Replace normal <img src="...">
    content = content.replace(/src="([^"]+)"/g, (match, src) => {
        if ((src.match(/\.(png|jpg|jpeg|gif|webp|JPG)(\?.*)?$/) || src.includes('unsplash')) && !src.includes('favicon')) {
            return `src="${getNextImage()}"`;
        }
        return match;
    });

    // Replace <meta ... content="..."> for og:image
    content = content.replace(/content="([^"]+)"/g, (match, src) => {
        if ((src.match(/\.(png|jpg|jpeg|gif|webp|JPG)(\?.*)?$/) || src.includes('unsplash')) && !src.includes('favicon')) {
            return `content="https://jelajah-gunung-bromo.id/${getNextImage()}"`;
        }
        return match;
    });

    // Replace schema images specifically
    content = content.replace(/"(https:\/\/jelajah-gunung-bromo\.id\/assets\/img\/[^"]*|https:\/\/images\.unsplash\.com[^"]*)"/g, (match) => {
        return `"https://jelajah-gunung-bromo.id/${getNextImage()}"`;
    });

    fs.writeFileSync(filePath, content, 'utf8');
}

const cssFile = path.join(dir, 'assets', 'css', 'style.css');
if (fs.existsSync(cssFile)) {
    let cssContent = fs.readFileSync(cssFile, 'utf8');
    cssContent = cssContent.replace(/url\(['"]?([^'"\)]+)['"]?\)/g, (match, src) => {
        if (src.match(/\.(png|jpg|jpeg|gif|webp|JPG)(\?.*)?$/)) {
            const nextImg = getNextImage().replace('assets/img/', '');
            return `url('../img/${nextImg}')`;
        }
        return match;
    });
    fs.writeFileSync(cssFile, cssContent, 'utf8');
}

console.log('Images successfully replaced across HTML and CSS files.');
