FROM golang:latest as build

WORKDIR /src/

COPY . /src/
RUN CGO_ENABLED=0 go build

FROM ubuntu:latest as runtime

RUN apt update && apt install curl wget libicu70 -y

COPY --from=build /src/autoformat /
COPY --from=build /src/*.sh /

ENTRYPOINT ["/autoformat"]
# ENTRYPOINT ["/bin/sh"]
