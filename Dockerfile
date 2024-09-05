FROM rocker/rstudio

RUN apt update && apt install -y man-db && yes | unminimize && rm -rf /var/lib/apt/lists/*

CMD ["/init"]
