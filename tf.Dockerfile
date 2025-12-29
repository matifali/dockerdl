ARG BASE_IMAGE=matifali/dockerdl-base:latest
FROM ${BASE_IMAGE}
USER ubuntu
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
# Tensorflow Package version passed as build argument e.g. --build-arg TF_VERSION=2.9.2
# A blank value will install the latest version
ARG TF_VERSION=
USER root
# Install packages inside the new environment
RUN uv pip install --no-cache --system --break-system-packages --upgrade tensorflow${TF_VERSION:+==${TF_VERSION}} && \
    find /usr/local/lib/python3.* -name '__pycache__' -exec rm -rf {} +
USER ubuntu
