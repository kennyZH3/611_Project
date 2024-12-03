FROM --platform=linux/amd64 rocker/verse


RUN apt update && apt install -y git man-db && yes | unminimize && rm -rf /var/lib/apt/lists/*

WORKDIR /home/rstudio/

CMD ["/init"]

RUN R -e "install.packages('matlab')"
RUN R -e "install.packages(\"tinytex\")"
RUN R -e "tinytex::install_tinytex(force = TRUE)"
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('htmlwidgets')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('gridExtra')"
RUN R -e "install.packages('nnet')"
RUN R -e "install.packages('gbm')"

