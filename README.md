# postgres-wal2json

Builds a PostgreSQL image for Docker based on the official image but with the `wal2json` extension installed. This allows you to configure PostgreSQL for `wal_level` of `logical` and thereafter create a logical replication slot.

```sql
SELECT pg_create_logical_replication_slot('my_slot', 'wal2json')
```
The above creates `my_slot` which you can read as JSON changes using the select statement below.
```sql
SELECT * FROM pg_logical_slot_get_changes('my_slot', NULL, NULL)
```
Swap `get` for `peek` in order to read any changes non-destructively. Changes appear in the `data` column as JSON, e.g.
```json
{
  "change": [
    {
      "kind": "insert",
      "schema": "public",
      "table": "my_table",
      "columnnames": [
        "my_colume"
      ],
      "columntypes": [
        "text"
      ],
      "columnvalues": [
        "hello world"
      ]
    }
  ]
}
```

## References

* [Official Image](https://hub.docker.com/_/postgres)
* [wal2json](https://github.com/eulerto/wal2json)
* [pg_replication_slots](https://www.postgresql.org/docs/current/view-pg-replication-slots.html)
