INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;
CREATE VIEW wdpa AS SELECT * FROM ST_READ('/data/wdpa.gpkg', 'wdpa_polygons');
COPY (SELECT wdpa.* REPLACE(SHAPE as geometry), ST_XMIN(SHAPE) as minx, ST_YMIN(SHAPE) as miny, ST_XMAX(SHAPE) as maxx, ST_YMAX(SHAPE) as maxy FROM wdpa ORDER BY ST_Hilbert(SHAPE, ST_Extent(ST_MakeEnvelope(-180, -90, 180, 90)))) TO '/data/wdpa.parquet' (FORMAT PARQUET, COMPRESSION zstd);
