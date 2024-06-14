FROM golang:1.16

WORKDIR /usr/src/app

COPY . .

RUN go build

RUN go test ./...

RUN adduser appuser

RUN chown appuser .

USER appuser

EXPOSE 8080

CMD ./server