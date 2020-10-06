FROM rocker/verse 
MAINTAINER Sean Beatty <sean_beatty@med.unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages('gridExtra')"
RUN R -e "install.packages('plotly')"
