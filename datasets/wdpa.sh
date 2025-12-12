#!/bin/bash

# FROM https://www.protectedplanet.net/en/thematic-areas/wdpa?tab=WDPA
# Convert the GDB to Parquet format using ogr2ogr
#wget -P /data/ https://d1gam3xoknrgr2.cloudfront.net/current/WDPA_Dec2025_Public.zip
#unzip /data/WDPA_Dec2025_Public.zip -d /data/wdpa_dec2025_public   
ogr2ogr -f Parquet /data/wdpa.gpkg /data/wdpa_dec2025_public/WDPA_Dec2025_Public.gdb wdpa_polygons -lco GEOMETRY=AS_WKB -nlt PROMOTE_TO_MULTI -nln wdpa
/root/.duckdb/cli/latest/duckdb < /datasets/wdpa.sql
s5cmd cp --acl "public-read" /data/wdpa.parquet s3://bq-io/vectors-cloud/wdpa/

# docker compose run --rm gdal /datasets/wdpa.sh

