#!/bin/bash

# Download the Marine Regions EEZ dataset and save it to /data path as it is protected by a form
# https://marineregions.org/download_file.php?name=World_EEZ_v12_20231025_gpkg.zip 
# Convert the GeoPackage to Parquet format using ogr2ogr
ogr2ogr -f Parquet /data/eez_v12.parquet /data/eez_v12.gpkg 
s5cmd cp --acl "public-read" /data/eez_v12.parquet s3://bq-io/vectors-cloud/marine_regions_eez/

# docker compose run --rm gdal /datasets/marine_regions_eez.sh