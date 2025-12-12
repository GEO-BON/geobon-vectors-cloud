FROM ghcr.io/osgeo/gdal:ubuntu-full-3.12.0 as gdal

WORKDIR /app

RUN apt-get update && apt-get install -y wget
RUN curl https://install.duckdb.org | sh
RUN wget https://github.com/peak/s5cmd/releases/download/v2.3.0/s5cmd_2.3.0_linux_amd64.deb

RUN dpkg -i s5cmd_2.3.0_linux_amd64.deb
