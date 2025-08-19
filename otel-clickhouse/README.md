# Using Otel-collector to receive consent event and export to ClickhouseDB

## Setup
```
docker compose up -d
```

## Example request
```
curl -X POST http://localhost:4318/v1/logs \
  -H "Content-Type: application/json" \
  -d '{
    "resourceLogs": [
      {
        "resource": {
          "attributes": [
            { "key": "service.name", "value": { "stringValue": "consent-frontend" } }
          ]
        },
        "scopeLogs": [
          {
            "logRecords": [
              {
                "timeUnixNano": "1697040000000000000",
                "severityNumber": 9,
                "severityText": "INFO",
                "body": { "stringValue": "User consented" },
                "attributes": [
                  { "key": "userId", "value": { "stringValue": "user123" } },
                  { "key": "policyVersion", "value": { "stringValue": "v1.2" } },
                  { "key": "region", "value": { "stringValue": "EU" } }
                ]
              }
            ]
          }
        ] 
```
Can see the logs on consent_logs tables
```
./clickhouse -u user
## enter pass

select * from consent_logs
```
Then you will see the consent log from stdout :tada: .