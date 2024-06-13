FROM golang:1.16

WORKDIR /usr/src/app

ENV REQUEST_ORIGIN=http://127.0.0.1:5000

COPY . .

RUN go build

RUN go test ./...

EXPOSE 8080

CMD ./server
