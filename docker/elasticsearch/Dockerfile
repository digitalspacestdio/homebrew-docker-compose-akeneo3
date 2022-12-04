ARG COMPOSE_PROJECT_ELASTICSEARCH_VERSION=6.5.4
FROM docker.elastic.co/elasticsearch/elasticsearch:${COMPOSE_PROJECT_ELASTICSEARCH_VERSION}
LABEL name="elasticsearch:${COMPOSE_PROJECT_ELASTICSEARCH_VERSION}-akeneo3"
RUN bin/elasticsearch-plugin install analysis-icu
RUN bin/elasticsearch-plugin install analysis-phonetic
