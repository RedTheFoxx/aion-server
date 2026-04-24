FROM eclipse-temurin:25-jdk

WORKDIR /opt/aion

COPY run-server.sh /usr/local/bin/run-aion-server
RUN chmod +x /usr/local/bin/run-aion-server

ENTRYPOINT ["/usr/local/bin/run-aion-server"]
