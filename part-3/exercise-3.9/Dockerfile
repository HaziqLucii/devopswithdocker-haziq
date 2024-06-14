# Stage 1: Build stage
FROM golang:1.16 AS build

WORKDIR /app

ENV REQUEST_ORIGIN=http://127.0.0.1:5000

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o server && \
    adduser appuser && \
    chown -R appuser /app

USER appuser

# Stage 2: Runtime stage
FROM scratch

WORKDIR /app

COPY --from=build /app/server .

EXPOSE 8080

CMD ["/app/server"]