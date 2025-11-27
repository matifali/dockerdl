FROM matifali/dockerdl-base:latest
USER ubuntu
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
USER root
# Install pytorch
RUN uv pip install --system --break-system-packages --upgrade torch torchvision torchaudio torchtext torchserve && \
    uv pip install --system --break-system-packages --upgrade lightning
USER ubuntu
