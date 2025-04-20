FROM node:18-slim AS scraper
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
WORKDIR /app
RUN apt-get update && apt-get install -y chromium && apt-get clean
COPY package.json .
RUN npm install
COPY scrape.js .
ARG SCRAPE_URL
ENV SCRAPE_URL=$SCRAPE_URL
RUN node scrape.js

FROM python:3.10-slim
WORKDIR /app
COPY --from=scraper /app/scraped_data.json .
COPY server.py .
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["python", "server.py"]
