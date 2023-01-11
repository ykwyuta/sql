CREATE TABLE hoge_history (
	hoge_id BIGINT,
	history_id INT,
	col1 INT,
	col2 INT,
	rgdt DATETIME,
	CONSTRAINT pk_hoge_history PRIMARY KEY(hoge_id, history_id)
);

CREATE INDEX idx_hoge_history_rgdt ON hoge_history (rgdt);

INSERT INTO hoge_history(hoge_id, history_id, col1, col2, rgdt)
SELECT
f1.id AS hoge_id, 
f2.id AS history_id, 
f1.id % 10 AS col1, 
CASE WHEN f1.id % 3 = 0 THEN 0 ELSE f1.id END AS col2, 
DATEADD(DAY, f1.id, '2022-12-27 00:00') AS rgdt
FROM(SELECT TOP(10 * 10000) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o, sys.objects o1, sys.objects o2) f1, 
(SELECT TOP(10) ROW_NUMBER() OVER (ORDER BY object_id) AS id FROM sys.objects) f2;
