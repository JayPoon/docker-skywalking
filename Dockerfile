# FROM openjdk:8
FROM openjdk:8-alpine
MAINTAINER  jay.pan@infinitus-int.com

ENV ZK_ADDRESSES=127.0.0.1:2181  ES_CLUSTER_NAME=CollectorDBCluster ES_ADDRESSES=localhost:9300 BIND_HOST=localhost \
 NAMING_BIND_HOST=localhost NAMING_BIND_PORT=10800 REMOTE_BIND_PORT=11800  AGENT_GRPC_BIND_PORT=11800  \
 AGENT_JETTY_BIND_HOST=localhost  AGENT_JETTY_BIND_PORT=12800  UI_JETTY_BIND_PORT=12800  UI_JETTY_BIND_HOST=localhost
ENV SKYWLK_HOME = /usr/local/skywalking-collector

ADD docker-entrypoint.sh /

# WORKDIR ${SKYWLK_HOME}
WORKDIR /usr/local/skywalking-collector
COPY bin bin
COPY collector-libs collector-libs
COPY config config
COPY webapp webapp

RUN chmod 755 /docker-entrypoint.sh && chmod 755 -R bin

EXPOSE 10800/tcp 11800/tcp 12800/tcp 

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/collectorServiceDocker.sh"]

#CMD ["bin/startup.sh"]