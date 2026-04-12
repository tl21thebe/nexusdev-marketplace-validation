FROM postgres:15
#loading environment
ENV POSTGRES_DB=${POSTGRES_DB}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
#copy SQL scripts
COPY schema.sql /docker-entrypoint-initdb.d/1-schema.sql
COPY sample-data.sql /docker-entrypoint-initdb.d/2-sample-data.sql
COPY queries.sql /docker-entrypoint-initdb.d/3-queries.sql
EXPOSE 5432