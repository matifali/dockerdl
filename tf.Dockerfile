ARG BASE_IMAGE=matifali/dockerdl-base:latest
FROM ${BASE_IMAGE}
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
# Tensorflow Package version passed as build argument e.g. --build-arg TF_VERSION=2.21.0
# A blank value will install the latest version
ARG TF_VERSION=
RUN uv pip install --no-cache --upgrade "tensorflow[and-cuda]${TF_VERSION:+==${TF_VERSION}}" && \
    find "${VIRTUAL_ENV}/lib" -name '__pycache__' -exec rm -rf {} +
