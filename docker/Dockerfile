FROM iseedevelopers/isee:latest
MAINTAINER Cameron Hyde <c.hyde@qcif.edu.au>

RUN apt-get update -qq && apt-get install -y python3-pip net-tools

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get autoremove -y

# Don't actually use this currently?
RUN pip3 install galaxy-ie-helpers

COPY ./scripts/* /scripts/

WORKDIR /import

ARG PORT
ENV PORT=$PORT

EXPOSE $PORT
