FROM openjdk:8-jre-alpine

RUN apk add --update bash && rm -rf /var/cache/apk/*

COPY src /src

# Adopt windows created files for centos
RUN cd /src; find . -name '*.sh' -exec sed -i 's/\r//g' {} \;

# Un-tar kafka
RUN cd /src; mkdir kafka && tar xf kafka.tgz -C kafka --strip-components 1
RUN cd /src; rm kafka.tgz;

RUN chmod -R +x /src

ENTRYPOINT /src/start.sh


