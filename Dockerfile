FROM rocker/verse 
MAINTAINER Sean Beatty <sean_beatty@med.unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages('gridExtra')"
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('ggpubr')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('gbm')"
RUN R -e "install.packages(c('shiny','plotly'))";
RUN apt update -y && apt install -y python3-pip
RUN pip3 install jupyter jupyterlab
RUN pip3 install numpy pandas sklearn plotnine matplotlib pandasql bokeh