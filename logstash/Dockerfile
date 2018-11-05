FROM docker.elastic.co/logstash/logstash-oss:6.4.2

RUN bin/logstash-plugin install logstash-input-github

# COPY ./config/* /usr/share/logstash/config/
COPY ./pipeline/* /usr/share/logstash/pipeline/