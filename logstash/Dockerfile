FROM docker.elastic.co/logstash/logstash:6.4.3

ENV ELASTIC_USERNAME elastic
ENV ELASTIC_HOST "elastic-svc.default.svc.cluster.local"
ARG ELASTIC_PASSWORD

RUN bin/logstash-plugin install logstash-input-github

# COPY ./config/* /usr/share/logstash/config/
# COPY ./config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY ./pipeline/* /usr/share/logstash/pipeline/
