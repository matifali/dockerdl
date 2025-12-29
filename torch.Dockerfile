ARG BASE_IMAGE=matifali/dockerdl-base:latest
FROM ${BASE_IMAGE}
USER ubuntu
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
USER root
# Install pytorch
RUN uv pip install --no-cache --system --break-system-packages --upgrade torch torchvision torchaudio torchtext torchserve && \
    uv pip install --no-cache --system --break-system-packages --upgrade lightning && \
    find /usr/local/lib/python3.* -name '__pycache__' -exec rm -rf {} +
USER ubuntu
