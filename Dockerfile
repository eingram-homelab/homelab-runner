FROM ghcr.io/actions/actions-runner:2.334.0

USER root
RUN export PATH=$PATH:/home/runner/.local/bin && \
    apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER runner