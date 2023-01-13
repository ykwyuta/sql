CREATE EXTENSION file_fdw;

CREATE SERVER fs FOREIGN DATA WRAPPER file_fdw;

CREATE FOREIGN TABLE external_csv
(c1 text, c2 text, c3 text)
SERVER fs
OPTIONS (filename '/opt/temp.csv', format 'csv', header 'true', encoding 'utf8');

COPY (SELECT
t1.c1, t1.c2, t1.c3, t2.c1 AS c4, t2.c2 AS c5, t2.c3 AS c6
FROM external_csv t1 INNER JOIN external_csv t2 ON t1.c1 = t2.c1) 
TO '/opt/pgtemp/temp2.csv' With CSV DELIMITER ',';

CREATE FOREIGN TABLE external_csv2
(c1 text, c2 text, c3 text, c4 text, c5 text, c6 text)
SERVER fs
OPTIONS (filename '/opt/pgtemp/temp2.csv', format 'csv', header 'false', encoding 'utf8');