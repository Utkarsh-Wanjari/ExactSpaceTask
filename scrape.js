const puppeteer = require('puppeteer');
const fs = require('fs');

const url = process.env.SCRAPE_URL;
if (!url) {
  console.error("SCRAPE_URL not set.");
  process.exit(1);
}

(async () => {
  const browser = await puppeteer.launch({ headless: true, args: ['--no-sandbox'] });
  const page = await browser.newPage();
  await page.goto(url);

  const data = await page.evaluate(() => ({
    title: document.title,
    h1: document.querySelector('h1')?.innerText || "No h1 found"
  }));

  fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
  await browser.close();
})();
