FROM iseedevelopers/isee:latest
MAINTAINER Cameron Hyde <c.hyde@qcif.edu.au>

RUN apt-get update -qq && apt-get install -y python3-pip net-tools

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get autoremove -y

RUN pip3 install galaxy-ie-helpers

# To suppress warnings in R - currently just creates more errors
# RUN apt-get install -y libiodbc2-dev
# RUN Rscript -e 'install.packages(c("RODBC"))'

COPY ./scripts/* /scripts/

WORKDIR /import

EXPOSE 8888
