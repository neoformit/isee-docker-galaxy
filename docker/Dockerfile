FROM iseedevelopers/isee:latest
# FROM iseedevelopers/isee:RELEASE_3_10 ?

RUN apt-get update -qq && apt-get install -y python3-pip

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get autoremove -y

RUN pip3 install galaxy-ie-helpers

COPY ./scripts/* /scripts/

WORKDIR /import

# ENTRYPOINT ["/scripts/run.sh"]  # This works but may be unconventional?
CMD /scripts/run.sh

EXPOSE 8888
