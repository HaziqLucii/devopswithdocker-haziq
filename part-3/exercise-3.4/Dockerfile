FROM docker:latest

WORKDIR /app

COPY ./clone-and-build.sh /app/bin/clone-and-build.sh

RUN chmod +x /app/bin/clone-and-build.sh

ENTRYPOINT [ "/bin/sh", "/app/bin/clone-and-build.sh" ]