# Sent user consent with frontend app and collect with otel and clickhouse

## Setup
```
docker compose up -d
```

now you can sent a user consent on [http://localhost:8080](http://localhost:8080)

Can see the logs on consent_logs tables
```
docker exec -it clickhouse bash
clickhouse -u user
## enter pass

select * from consent_logs
```
Then you will see the consent log from stdout :tada: .