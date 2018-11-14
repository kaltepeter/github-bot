FROM docker.elastic.co/kibana/kibana:6.4.3
ENV ELASTIC_USERNAME kibana
ARG ELASTIC_PASSWORD
ARG ELASTIC_URL
COPY ./kibana.yml /usr/share/kibana/config/kibana.yml
