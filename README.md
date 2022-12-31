# sql

devcontainerからSQL Serverに接続する場合は以下

```bash
/opt/mssql-tools/bin/sqlcmd -S $MSSQL_HOST -U $MSSQL_USER -P $MSSQL_PASSWORD
```

# SQL Server

どのような実行計画が作られるかを試してみます。SQL Server 2019の結果です。

| ケース                                      | SQL                                                          | 実行計画    |
| ------------------------------------------- | ------------------------------------------------------------ | ----------- |
| クラスタ化インデックス + キー列             | SELECT col1 FROM test2022 WHERE col1 = 1                     | 001.sqlplan |
| クラスタ化インデックス + 非キー列           | SELECT col2 FROM test2022 WHERE col1 = 1                     | 002.sqlplan |
| インデックス + キー列                       | SELECT col2 FROM test2022 WHERE col2 = 1                     | 003.sqlplan |
| インデックス + クラスタ化インデックスキー列 | SELECT col1 FROM test2022 WHERE col2 = 1                     | 004.sqlplan |
| インデックス + 付加列                       | SELECT col3 FROM test2022 WHERE col2 = 1                     | 005.sqlplan |
| インデックス + 非キー列                     | SELECT col3 FROM test2022 WHERE col2 = 1                     | 006.sqlplan |
| 先頭列だが選択性が低い＋非キー列            | SELECT col4 FROM test2022 WHERE col5 = 1                     | 007.sqlplan |
| 先頭列だが選択性が低い＋キー列              | SELECT col8 FROM test2022 WHERE col5 = 1                     | 008.sqlplan |
| 日付暗黙型変換キー列                        | SELECT col9 FROM test2022 WHERE col9 = '2025-03-07 00:00:00.000' | 009.sqlplan |
| 先頭列ではないキー列                        | SELECT col5 FROM test2022 WHERE col8 = '2025-03-07 00:00:00.000' | 010.sqlplan |

おまけ

| SQL                                                          | 実行計画    |
| ------------------------------------------------------------ | ----------- |
| SELECT p.* FROM test2022 p INNER JOIN test2022c c ON p.col1 = c.pcol1 WHERE ccol3 = 10 | 100.sqlplan |
| SELECT c.* FROM test2022 p INNER JOIN test2022c c ON p.col1 = c.pcol1 WHERE ccol3 = 10 | 101.sqlplan |
| SELECT c.pcol1 FROM test2022 p INNER JOIN test2022c c ON p.col1 = c.pcol1 WHERE ccol3 = 10 | 102.sqlplan |
| SELECT c.pcol1 FROM test2022 p INNER JOIN test2022c c ON p.col1 = c.pcol1 WHERE ccol2 = 10 | 103.sqlplan |
| SELECT c.pcol1 FROM test2022 p INNER JOIN test2022c c ON p.col1 = c.pcol1 WHERE DAY(p.col9) = 10 | 104.sqlplan |
| ALTER TABLE test2022 ADD col10 AS DAY(col9) PERSISTED;<br />CREATE INDEX idx_test2022_col10 ON test2022 (col10);<br />SELECT c.pcol1 FROM test2022 p INNER JOIN test2022c c ON p.col1 = c.pcol1 WHERE DAY(p.col9) = 10; | 105.sqlplan |
