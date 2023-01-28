DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS item;

CREATE TABLE store (
	store_id INT,
	name NVARCHAR(20),
	is_deleted TINYINT,
	CONSTRAINT pk_stock PRIMARY KEY(store_id)
);

INSERT INTO store (store_id, name, is_deleted)
SELECT
f.id, 'STORE ' + CHAR(f.id % 26 + 65), CASE f.id % 8 WHEN 0 THEN 1 ELSE 0 END
FROM(SELECT TOP(10 * 10000) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o, sys.objects o1, sys.objects o2) f
WHERE f.id < 27;

CREATE TABLE item (
	item_id INT,
	name NVARCHAR(20),
	description NVARCHAR(MAX),
	store_id INT,
	rgdt DATETIME,
	updt DATETIME,
	is_deleted TINYINT,
	CONSTRAINT pk_item PRIMARY KEY(item_id)
);

INSERT INTO item (item_id, name, description, store_id, rgdt, updt, is_deleted)
SELECT
f.id AS item_id, 
'ITEM ' + CHAR(f.id % 26 + 65) + RIGHT('00000' + CAST(f.id AS NVARCHAR(10)), 5) AS name, 
'DESCRIPTION ' + CHAR(f.id % 26 + 65) + RIGHT('00000' + CAST(f.id AS NVARCHAR(10)), 5) AS description,
f.id % 26 + 1 AS store_id,
DATEADD(DAY, f.id, '2022-10-27 00:00') AS rgdt, 
DATEADD(DAY, f.id, '2022-12-27 00:00') AS updt,
CASE f.id % 8 WHEN 0 THEN 1 ELSE 0 END AS is_deleted
FROM(SELECT TOP(10 * 10000) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o, sys.objects o1, sys.objects o2) f
