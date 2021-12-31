FROM golang:1.16-buster as build

WORKDIR /
# COPY go.mod ./
# COPY go.sum ./
# ADD . /
COPY *.go ./
RUN go mod download
COPY . ./

RUN go build -o main -a /main.go
FROM debian:buster-slim
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*
# FROM gcr.io/distroless/base
COPY --from=build /main /
# EXPOSE 8080
ENTRYPOINT [ "/main" ]


