FROM rocker/rstudio


RUN apt update && apt install -y git man-db && yes | unminimize && rm -rf /var/lib/apt/lists/*

CMD ["/init"]

RUN R -e "install.packages('matlab')"

