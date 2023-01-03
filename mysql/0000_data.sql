CREATE DATABASE dev CHARACTER SET utf8mb4 COLLATE utf8mb4_ja_0900_as_cs_ks;

use dev;

CREATE TABLE test2022 (
	col1 INT,
	col2 INT,
	col3 INT,
	col4 INT,
	col5 INT,
	col6 INT,
	col7 INT,
	col8 DATETIME,
	col9 DATETIME,
	CONSTRAINT pk_test2022 PRIMARY KEY(col1)
);

CREATE INDEX idx_test2022_col2 ON test2022(col2, col3);

CREATE INDEX idx_test2022_col6 ON test2022(col6);

CREATE INDEX idx_test2022_col7 ON test2022(col7);

CREATE INDEX idx_test2022_col8 ON test2022(col5, col8);

CREATE INDEX idx_test2022_col9 ON test2022(col9, col5);

INSERT INTO test2022(col1, col2, col3, col4, col5, col6, col7, col8, col9)
SELECT
f.id, f.id, 0, f.id, 
f.id % 10 AS col5, 
CASE WHEN f.id % 3 = 0 THEN 0 ELSE f.id END AS col6, 
CASE WHEN f.id % 10000 = 0 THEN NULL ELSE f.id END AS col7, 
DATE_ADD('2022-12-27 00:00', INTERVAL 1 DAY) AS col8, 
DATE_ADD('2022-12-27 00:00', INTERVAL 1 DAY) AS col9
FROM(SELECT ROW_NUMBER() OVER (ORDER BY o.Enabled) AS id FROM sys.metrics o, sys.metrics o1 LIMIT 100000) f;

CREATE TABLE test2022c (
	pcol1 INT,
	ccol1 INT,
	ccol2 INT,
	ccol3 INT,
	ccol4 INT,
	CONSTRAINT pk_test2022c PRIMARY KEY(pcol1, ccol1)
);

CREATE INDEX idx_test2022c_ccol2 ON test2022c(ccol2);

CREATE INDEX idx_test2022c_ccol3 ON test2022c(ccol3);

INSERT INTO test2022c (pcol1, ccol1, ccol2, ccol3, ccol4)
SELECT 
col1 AS pcol1, 
ROW_NUMBER() OVER (PARTITION BY f.col1 ORDER BY t) AS ccol1,
f.t AS ccol2,
ROW_NUMBER() OVER (ORDER BY t) AS ccol3,
f.col3 AS ccol4
FROM (SELECT * FROM test2022, (SELECT col1 AS t FROM test2022 ORDER BY col1 LIMIT 10) c) f;

ANALYZE TABLE test2022;
ANALYZE TABLE test2022c;
