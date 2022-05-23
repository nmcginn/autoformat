FROM golang:latest as build

WORKDIR /src/

COPY . /src/
RUN CGO_ENABLED=0 go build

FROM ubuntu:latest as runtime

RUN apt update && apt install curl wget libicu70 -y

COPY --from=build /src/*.sh /

RUN /dotnet-install.sh -c 6.0
ENV PATH="/root/.dotnet:${PATH}"
RUN dotnet tool install --global dotnet-format --version 5.1.250801

COPY --from=build /src/autoformat /

ENTRYPOINT ["/autoformat"]
# ENTRYPOINT ["/bin/sh"]
