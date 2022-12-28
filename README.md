# sql

devcontainerからSQL Serverに接続する場合は以下

```bash
/opt/mssql-tools/bin/sqlcmd -S $MSSQL_HOST -U $MSSQL_USER -P $MSSQL_PASSWORD
```

# SQL Server

どのような実行計画が作られるかを試してみます。SQL Server 2019の結果です。

| ケース                                      | SQL                                      | 実行計画    |
| ------------------------------------------- | ---------------------------------------- | ----------- |
| クラスタ化インデックス + キー列             | SELECT col1 FROM test2022 WHERE col1 = 1 | 001.sqlplan |
| クラスタ化インデックス + 非キー列           | SELECT col2 FROM test2022 WHERE col1 = 1 | 002.sqlplan |
| インデックス + キー列                       | SELECT col2 FROM test2022 WHERE col2 = 1 | 003.sqlplan |
| インデックス + クラスタ化インデックスキー列 | SELECT col1 FROM test2022 WHERE col2 = 1 | 004.sqlplan |
| インデックス + 付加列                      | SELECT col3 FROM test2022 WHERE col2 = 1 | 005.sqlplan |
| インデックス + 非キー列                      | SELECT col3 FROM test2022 WHERE col2 = 1 | 006.sqlplan |
