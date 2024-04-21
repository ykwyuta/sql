DROP TABLE IF EXISTS test2022row;

CREATE TABLE test2022row (
	col1 INT,
	col2 INT,
	col3 INT,
	col4 INT,
	col5 INT,
	col6 INT,
	col7 INT,
	col8 DATETIME,
	col9 DATETIME
	CONSTRAINT pk_test2022row PRIMARY KEY(col1)
);
CREATE INDEX idx_test2022_col2 ON test2022row(col2) INCLUDE(col3);

CREATE INDEX idx_test2022_col6 ON test2022row(col6);

CREATE INDEX idx_test2022_col7 ON test2022row(col7);

CREATE INDEX idx_test2022_col8 ON test2022row(col5, col8);

CREATE INDEX idx_test2022_col9 ON test2022row(col9, col5);

INSERT INTO test2022row(col1, col2, col3, col4, col5, col6, col7, col8, col9)
SELECT
f.id, f.id, 0, f.id, 
f.id % 10 AS col5, 
CASE WHEN f.id % 3 = 0 THEN 0 ELSE f.id END AS col6, 
CASE WHEN f.id % 10000 = 0 THEN NULL ELSE f.id END AS col7, 
DATEADD(MINUTE, f.id, '2022-12-27 00:00') AS col8, 
DATEADD(MINUTE, f.id, '2022-12-27 00:00') AS col9
FROM(SELECT TOP(1000 * 10000) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o, sys.objects o1, sys.objects o2, sys.objects o3) f;

UPDATE STATISTICS test2022row;

DROP TABLE IF EXISTS test2022col;

CREATE TABLE test2022col (
	col1 INT,
	col2 INT,
	col3 INT,
	col4 INT,
	col5 INT,
	col6 INT,
	col7 INT,
	col8 DATETIME,
	col9 DATETIME
	CONSTRAINT pk_test2022col PRIMARY KEY(col1),
	INDEX idx_test2022col CLUSTERED COLUMNSTORE);
GO


INSERT INTO test2022col(col1, col2, col3, col4, col5, col6, col7, col8, col9)
SELECT
f.id, f.id, 0, f.id, 
f.id % 10 AS col5, 
CASE WHEN f.id % 3 = 0 THEN 0 ELSE f.id END AS col6, 
CASE WHEN f.id % 10000 = 0 THEN NULL ELSE f.id END AS col7, 
DATEADD(MINUTE, f.id, '2022-12-27 00:00') AS col8, 
DATEADD(MINUTE, f.id, '2022-12-27 00:00') AS col9
FROM(SELECT TOP(1000 * 10000) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o, sys.objects o1, sys.objects o2, sys.objects o3) f;

DROP TABLE IF EXISTS test2022col2;

CREATE TABLE test2022col2 (
	col1 INT,
	col2 INT,
	col3 INT,
	col4 INT,
	col5 INT,
	col6 INT,
	col7 INT,
	col8 DATETIME,
	col9 DATETIME
	CONSTRAINT pk_test2022col2 PRIMARY KEY(col1)
	)
GO

CREATE NONCLUSTERED COLUMNSTORE INDEX idx_test2022col2 ON test2022col2 (col3, col6);

INSERT INTO test2022col2(col1, col2, col3, col4, col5, col6, col7, col8, col9)
SELECT
f.id, f.id, 0, f.id, 
f.id % 10 AS col5, 
CASE WHEN f.id % 3 = 0 THEN 0 ELSE f.id END AS col6, 
CASE WHEN f.id % 10000 = 0 THEN NULL ELSE f.id END AS col7, 
DATEADD(MINUTE, f.id, '2022-12-27 00:00') AS col8, 
DATEADD(MINUTE, f.id, '2022-12-27 00:00') AS col9
FROM(SELECT TOP(1000 * 10000) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o, sys.objects o1, sys.objects o2, sys.objects o3) f;