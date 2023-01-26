CREATE TABLE test2022 (
	col1 INT,
	col2 INT,
	col3 INT,
	col4 INT,
	col5 INT,
	col6 INT,
	col7 INT,
	col8 TIMESTAMP,
	col9 TIMESTAMP,
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
MOD(f.id, 10) AS col5, 
CASE WHEN MOD(f.id, 3) = 0 THEN 0 ELSE f.id END AS col6, 
CASE WHEN MOD(f.id, 10000) = 0 THEN NULL ELSE f.id END AS col7, 
TO_TIMESTAMP('2022-12-27 00:00') + f.id AS col8,
TO_TIMESTAMP('2022-12-27 00:00') + f.id AS col9
FROM (SELECT ROWNUM AS id FROM ALL_CATALOG o, ALL_CATALOG o1 WHERE ROWNUM <= 100000) f
