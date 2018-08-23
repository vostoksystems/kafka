FROM alpine:3.7

COPY src /src

# Adopt windows created files for centos
RUN cd /src; find . -name '*.sh' -exec sed -i 's/\r//g' {} \;

# Un-tar kafka
RUN chmod -R +x /src
RUN cd /src
RUN tar -xzf kafka.tgz

ENTRYPOINT /src/start.sh


