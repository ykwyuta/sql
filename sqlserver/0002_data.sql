DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS item;

CREATE TABLE store (
	store_id INT,
	name NVARCHAR(20) NOT NULL,
	is_deleted TINYINT NOT NULL DEFAULT 0,
	CONSTRAINT pk_stock PRIMARY KEY(store_id)
);

INSERT INTO store (store_id, name, is_deleted)
SELECT
f.id, 'STORE ' + CHAR(f.id % 26 + 65), CASE f.id % 8 WHEN 0 THEN 1 ELSE 0 END
FROM(SELECT TOP(10 * 10000) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o, sys.objects o1, sys.objects o2) f
WHERE f.id < 27;

CREATE TABLE item (
	item_id INT,
	name NVARCHAR(20) NOT NULL,
	description NVARCHAR(MAX) NOT NULL,
	store_id INT NOT NULL,
	rgdt DATETIME NOT NULL,
	updt DATETIME NOT NULL,
	is_deleted TINYINT NOT NULL DEFAULT 0,
	CONSTRAINT pk_item PRIMARY KEY(item_id)
);

INSERT INTO item (item_id, name, description, store_id, rgdt, updt, is_deleted)
SELECT
f.id AS item_id, 
'ITEM ' + CHAR(f.id % 26 + 65) + RIGHT('00000' + CAST(f.id AS NVARCHAR(10)), 5) AS name, 
'DESCRIPTION ' + CHAR(f.id % 26 + 65) + RIGHT('00000' + CAST(f.id AS NVARCHAR(10)), 5) AS description,
f.id % 26 + 1 AS store_id,
DATEADD(HOUR, f.id, '2021-10-27 00:00') AS rgdt, 
DATEADD(HOUR, f.id, '2021-12-27 00:00') AS updt,
CASE f.id % 8 WHEN 0 THEN 1 ELSE 0 END AS is_deleted
FROM(SELECT TOP(10 * 10000) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o, sys.objects o1, sys.objects o2) f

DROP TABLE IF EXISTS price;
DROP TABLE IF EXISTS stock;

CREATE TABLE price (
	price_id INT,
	item_id INT NOT NULL,
	price MONEY NOT NULL,
    startdt DATETIME NOT NULL,
	enddt DATETIME NOT NULL,
	CONSTRAINT pk_price PRIMARY KEY(price_id)
);

INSERT INTO price (price_id, item_id, price, startdt, enddt)
SELECT
ROW_NUMBER() OVER (ORDER BY f.id) AS price_id,
i.item_id,
10000 + f.id * 100 % 10000 AS price,
DATEADD(DAY, f.id, i.rgdt) AS startdt,
DATEADD(DAY, f.id + 5, i.rgdt) AS enddt
FROM item i, (SELECT TOP(100) ROW_NUMBER() OVER (ORDER BY o.object_id) AS id FROM sys.objects o) f
