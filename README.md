1. How to build the Docker image.

--> sudo docker build --build-arg SCRAPE_URL=https://internshala.com/ -t scrap:v1 .

2. How to pass the URL to be scraped (via environment variables or
command-line arguments).

-->In Dockerfile:
    ARG SCRAPE_URL
    ENV SCRAPE_URL=$SCRAPE_URL

3. How to run the container.

--> sudo docker run -d -p 5000:5000 scrap:v1

4. How to access the hosted scraped data

--> Open browser: http://13.239.55.159:5000 
                  
