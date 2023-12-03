FROM matifali/dockerdl-base:latest
# Install as user 1000
USER 1000
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
# Install pytorch
RUN pip install --upgrade --no-cache-dir torch torchvision torchaudio torchtext torchserve && \
    pip install --upgrade --no-cache-dir lightning && \
    pip cache purge
