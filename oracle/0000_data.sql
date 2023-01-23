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
