FROM ubuntu:latest as runtime

RUN apt update && apt install curl wget libicu70 -y

COPY *.sh /

RUN /dotnet-install.sh -c 6.0
ENV PATH="/root/.dotnet:${PATH}"
RUN dotnet tool install --global dotnet-format --version 5.1.250801

ENTRYPOINT ["/autoformat.sh"]
# ENTRYPOINT ["/bin/sh"]
