ARG COMPOSE_PROJECT_ELASTICSEARCH_VERSION=7.17.5
FROM docker.elastic.co/elasticsearch/elasticsearch:${COMPOSE_PROJECT_ELASTICSEARCH_VERSION}
LABEL name="elasticsearch:${COMPOSE_PROJECT_ELASTICSEARCH_VERSION}-akeneo6"
RUN bin/elasticsearch-plugin install analysis-icu
RUN bin/elasticsearch-plugin install analysis-phonetic
