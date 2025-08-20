CREATE TABLE IF NOT EXISTS otel_logs
(
        `Timestamp` DateTime64(9) CODEC(Delta(8), ZSTD(1)),
        `TraceId` String CODEC(ZSTD(1)),
        `SpanId` String CODEC(ZSTD(1)),
        `TraceFlags` UInt32 CODEC(ZSTD(1)),
        `SeverityText` LowCardinality(String) CODEC(ZSTD(1)),
        `SeverityNumber` Int32 CODEC(ZSTD(1)),
        `ServiceName` LowCardinality(String) CODEC(ZSTD(1)),
        `Body` String CODEC(ZSTD(1)),
        `ResourceSchemaUrl` String CODEC(ZSTD(1)),
        `ResourceAttributes` Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        `ScopeSchemaUrl` String CODEC(ZSTD(1)),
        `ScopeName` String CODEC(ZSTD(1)),
        `ScopeVersion` String CODEC(ZSTD(1)),
        `ScopeAttributes` Map(LowCardinality(String), String) CODEC(ZSTD(1)),
        `LogAttributes` Map(LowCardinality(String), String) CODEC(ZSTD(1))
) 
ENGINE = Null;

CREATE TABLE IF NOT EXISTS consent_logs
(
        `Body` String,
        `Timestamp` DateTime,
        `userId` String,
        `ipAddress` String,
        `policyVersion` String,
        `action` String,
        `region` String,
        `purposes` String
)
ENGINE = MergeTree
ORDER BY Timestamp;


CREATE MATERIALIZED VIEW IF NOT EXISTS consent_logs_mv TO consent_logs AS
SELECT
        Body, 
        Timestamp,
        LogAttributes['user_id'] AS userId,
        LogAttributes['ip_address'] AS ipAddress,
        LogAttributes['policy_version'] AS policyVersion,
        LogAttributes['action'] AS action,
        LogAttributes['region'] AS region,
        LogAttributes['purposes'] AS purposes
FROM otel_logs;