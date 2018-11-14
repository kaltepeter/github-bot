# mrll/docker-logstash

FROM: https://github.com/elastic/logstash-docker/tree/6.4

ADDS: https://www.elastic.co/guide/en/logstash/current/plugins-inputs-github.html

AND configures pipeline [./pipeline/logstash.conf](./pipeline/logstash.conf)

## build

```bash
./build.sh
```

## run for local dev

mounts the pipeline and config folders for dev. 

```bash
./run.sh
```