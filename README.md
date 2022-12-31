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
