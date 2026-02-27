const fs = require('fs');
const path = require('path');

const dir = process.cwd();

// Read index.html
const indexHtmlPaths = path.join(dir, 'index.html');
const indexContent = fs.readFileSync(indexHtmlPaths, 'utf8');

// Use powerful regex to extract the footer block from index.html
const indexFooterRegex = /(<!-- Footer -->\s*<footer[^>]*>[\s\S]*?<\/footer>\s*)(?=<!-- Floating Action Buttons -->)/i;
const match = indexContent.match(indexFooterRegex);

if (!match) {
    console.error("Could not find footer in index.html");
    process.exit(1);
}

const indexFooterBlock = match[1];

// Update all blog files
const htmlFiles = fs.readdirSync(dir).filter(f => f.startsWith('blog-') && f.endsWith('.html'));

for (const file of htmlFiles) {
    const filePath = path.join(dir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    
    const blogFooterRegex = /(<!-- Footer -->\s*<footer[^>]*>[\s\S]*?<\/footer>\s*)(?=<!-- Floating Action Buttons -->)/i;
    content = content.replace(blogFooterRegex, indexFooterBlock);
    
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Updated footer for ${file}`);
}

console.log('All footers copied successfully.');
