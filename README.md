# consent-logs

A minimal Consent API in Go that receives consent events, validates them, and emits structured logs.

## To run code
```
go run main.go
```

## Example request
```
curl -X POST http://localhost:8080/consent \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "abc123",
    "deviceId": "xyz789",
    "policyVersion": "v1.2",
    "categories": {
      "necessary": true,
      "analytics": false,
      "marketing": true
    },
    "region": "EU"
  }'
```
Then you will see the consent log from stdout :tada: .
