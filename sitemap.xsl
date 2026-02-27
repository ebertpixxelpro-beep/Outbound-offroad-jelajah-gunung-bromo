<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
                xmlns:html="http://www.w3.org/TR/REC-html40"
                xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
                xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>XML Sitemap</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style type="text/css">
          body { font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; color: #333; }
          #sitemap-list { margin: 20px auto; width: 80%; border-collapse: collapse; }
          #sitemap-list th { background-color: #f4f4f4; border: 1px solid #ccc; padding: 10px; text-align: left; }
          #sitemap-list td { border: 1px solid #ccc; padding: 10px; }
          #sitemap-list tr:nth-child(even) { background-color: #f9f9f9; }
          a { color: #0066cc; text-decoration: none; }
          a:hover { text-decoration: underline; }
          .header { text-align: center; margin-top: 30px; }
        </style>
      </head>
      <body>
        <div class="header">
          <h1>XML Sitemap</h1>
          <p>Sitemap ini di-generate untuk memudahkan Search Engine merayapi website Jelajah Gunung Bromo.</p>
        </div>
        <table id="sitemap-list">
          <tr>
            <th>URL Location</th>
            <th>Last Modified</th>
            <th>Change Frequency</th>
            <th>Priority</th>
          </tr>
          <xsl:for-each select="sitemap:urlset/sitemap:url">
            <tr>
              <td>
                <xsl:variable name="itemURL">
                  <xsl:value-of select="sitemap:loc"/>
                </xsl:variable>
                <a href="{$itemURL}">
                  <xsl:value-of select="sitemap:loc"/>
                </a>
              </td>
              <td><xsl:value-of select="sitemap:lastmod"/></td>
              <td><xsl:value-of select="sitemap:changefreq"/></td>
              <td><xsl:value-of select="sitemap:priority"/></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
