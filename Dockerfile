FROM alpine:latest

ARG TELEGRAF_VERSION
RUN apk -U add bash curl
ENV TELEGRAF_URL="https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_linux_arm64.tar.gz"
RUN curl $TELEGRAF_URL | tar -xzv -C /
ADD envtpl /usr/bin/envtpl
EXPOSE 8094 9126

ENV INFLUXDB_URL http://localhost:8086
ENV INTERVAL 10s
ENV OUTPUT_INFLUXDB_ENABLED     true
ENV OUTPUT_PROMETHEUS_ENABLED   false
ENV OUTPUT_CLOUDWATCH_ENABLED   false
ENV OUTPUT_KAFKA_ENABLED        false
ENV OUTPUT_NATS_ENABLED         false
ENV OUTPUT_FILE_ENABLED         false
ENV INPUT_KAFKA_ENABLED         false
ENV INPUT_NATS_ENABLED          false
ENV INPUT_CPU_ENABLED           true
ENV INPUT_DISK_ENABLED          true
ENV INPUT_DISKIO_ENABLED        true
ENV INPUT_KERNEL_ENABLED        true
ENV INPUT_MEM_ENABLED           true
ENV INPUT_PROCESS_ENABLED       true
ENV INPUT_SWAP_ENABLED          true
ENV INPUT_SYSTEM_ENABLED        true
ENV INPUT_NET_ENABLED           true
ENV INPUT_NETSTAT_ENABLED       true
ENV INPUT_DOCKER_ENABLED        true
ENV INPUT_LISTENER_ENABLED      false
ENV INPUT_HAPROXY_ENABLED       false

COPY telegraf.conf.tpl /etc/telegraf/telegraf.conf.tpl
COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]
CMD []
