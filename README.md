# sql

devcontainerからSQL Serverに接続する場合は以下

```bash
/opt/mssql-tools/bin/sqlcmd -S $MSSQL_HOST -U $MSSQL_USER -P $MSSQL_PASSWORD
```