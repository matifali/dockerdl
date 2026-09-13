ARG BASE_IMAGE=matifali/dockerdl-base:latest
FROM ${BASE_IMAGE}
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
# Install pytorch
RUN uv pip install --no-cache --upgrade torch torchvision torchaudio lightning && \
    find "${VIRTUAL_ENV}/lib" -name '__pycache__' -exec rm -rf {} +
