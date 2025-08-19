# syntax=docker/dockerfile:1

############################
# Build stage
############################
FROM golang:1.24-alpine AS builder
WORKDIR /src

# Copy module files first (better layer caching)
COPY go.mod ./
# If you have a go.sum, copy it too:
# COPY go.sum ./
RUN go mod download

# Copy source
COPY main.go ./

# Build a static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -trimpath -ldflags="-s -w" -o /out/consent-api

############################
# Runtime stage
############################
FROM debian:bookworm-slim
WORKDIR /go/app

# Copy binary from builder
COPY --from=builder /out/consent-api /go/app/consent-api

EXPOSE 8080
ENTRYPOINT ["/go/app/consent-api"]
