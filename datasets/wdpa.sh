#!/bin/bash

# FROM https://www.protectedplanet.net/en/thematic-areas/wdpa?tab=WDPA
# Convert the GDB to Parquet format using ogr2ogr
wget -P /data/ https://d1gam3xoknrgr2.cloudfront.net/current/WDPA_Dec2025_Public.zip
unzip /data/WDPA_Dec2025_Public.zip -d /data/wdpa_dec2025_public   
#ogr2ogr -f Parquet /data/wdpa.parquet /data/wdpa_dec2025_public/WDPA_Dec2025_Public.gdb WDPA_poly_Dec2025
/root/.duckdb/cli/latest/duckdb < /datasets/wdpa.sql
s5cmd cp --acl "public-read" /data/wdpa.parquet s3://bq-io/vectors-cloud/wdpa/

# docker compose run --rm gdal /datasets/wdpa.sh

