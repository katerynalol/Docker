FROM debian:12.13-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash appuser

WORKDIR /app

ENV EXAMPLE_LINC=https://example.com \
    TARGET=/data

COPY --chown=appuser:appuser fetch_data.sh .

RUN mkdir -p /data && \
    chown -R appuser:appuser /data && \
    chmod +x fetch_data.sh

VOLUME /data

USER appuser

ENTRYPOINT ["/app/fetch_data.sh"]