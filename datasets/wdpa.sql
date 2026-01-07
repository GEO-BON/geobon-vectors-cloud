INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;
CREATE VIEW wdpa AS SELECT * FROM ST_Read('/data/wdpa.fgb');
COPY (SELECT wdpa.* EXCLUDE(geom), geom as geometry, {'xmin': ST_XMin(geom), 'xmax': ST_XMax(geom), 'ymin':ST_YMin(geom), 'ymax':ST_YMax(geom)} AS bbox FROM wdpa WHERE abs(ST_XMax(geom)-ST_XMin(geom))<10) TO '/data/wdpa_duck.parquet'  (FORMAT parquet, ROW_GROUP_SIZE 2500);
