FROM golang:latest as build

WORKDIR /src/

COPY . /src/
RUN CGO_ENABLED=0 go build

FROM alpine:latest as runtime

COPY --from=build /src/autoformat /
COPY --from=build /src/*.sh /

ENTRYPOINT ["/autoformat"]
