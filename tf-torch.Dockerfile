FROM matifali/dockerdl-base:latest
# Install as user 1000
USER 1000
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
# Tensorflow Package version passed as build argument e.g. --build-arg TF_VERSION=2.9.2
# A blank value will install the latest version
ARG TF_VERSION=
# Install packages inside the new environment
RUN pip install --upgrade --no-cache-dir torch torchvision torchaudio torchtext torchserve && \
    pip install --upgrade --no-cache-dir lightning && \
    pip install --upgrade --no-cache-dir tensorflow${TF_VERSION:+==${TF_VERSION}} && \
    pip cache purge
