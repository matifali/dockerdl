FROM matifali/dockerdl-base:latest
# Install as user 1000
USER ubuntu
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
USER root
# Install pytorch
RUN uv pip install --system --break-system-packages --upgrade torch torchvision torchaudio torchtext torchserve && \
    uv pip install --system --break-system-packages --upgrade lightning
# Install as user 1000
USER ubuntu
