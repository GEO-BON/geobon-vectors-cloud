#!/bin/bash

# FROM https://www.protectedplanet.net/en/thematic-areas/wdpa?tab=WDPA
# Convert the GDB to Parquet format using ogr2ogr
#wget -P /data/ https://d1gam3xoknrgr2.cloudfront.net/current/WDPA_Dec2025_Public.zip
#unzip /data/WDPA_Dec2025_Public.zip -d /data/wdpa_dec2025_public   
ogr2ogr /data/wdpa.fgb /data/wdpa_dec2025_public/WDPA_Dec2025_Public.gdb WDPA_poly_Dec2025 -nlt PROMOTE_TO_MULTI -nln wdpa -simplify 0.00005 -makevalid
/root/.duckdb/cli/latest/duckdb < /datasets/wdpa.sql
#gpio convert /data/wdpa.fgb /data/wdpa.parquet
#gpio convert /data/wdpa_duck.parquet /data/wdpa.parquet
#gpio check all /data/tmp.parquet --fix --fix-output wdpa.parquet

s5cmd cp --acl "public-read" /data/wdpa_duck.parquet s3://bq-io/vectors-cloud/wdpa/wdpa.parquet

# docker compose run --rm gdal /datasets/wdpa.sh

