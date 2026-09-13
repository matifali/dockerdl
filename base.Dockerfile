# Literal tag (no ARG) so Dependabot can bump it
# Plain Ubuntu: CUDA/cuDNN come entirely from the torch and tensorflow[and-cuda] pip wheels;
# nvidia-container-toolkit mounts the driver, nvidia-smi and libnvidia-ml from the host
FROM ubuntu:26.04
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility
USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dependencies
ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    bash-completion \
    ca-certificates \
    curl \
    git \
    htop \
    nano \
    nvidia-modprobe \
    nvtop \
    openssh-client \
    sudo \
    tmux \
    unzip \
    vim \
    wget \
    zip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download and install zellij
RUN curl -fsSL -o zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-$(uname -m)-unknown-linux-musl.tar.gz" && \
    tar -xzf zellij.tar.gz -C /usr/local/bin && \
    rm zellij.tar.gz && \
    zellij --version

# uv-managed Python in a venv owned by `ubuntu`, so packages can be added without sudo
# TensorFlow has no 3.14 wheels yet, so 3.13 is the newest version that works everywhere
ARG PYTHON_VER=3.13
ENV UV_PYTHON_INSTALL_DIR=/opt/uv/python \
    VIRTUAL_ENV=/opt/venv \
    PATH="/opt/venv/bin:/home/ubuntu/.local/bin:${PATH}"
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_UNMANAGED_INSTALL=/usr/local/bin sh && \
    uv python install "${PYTHON_VER}" && \
    uv venv --python "${PYTHON_VER}" --seed "${VIRTUAL_ENV}" && \
    chown -R ubuntu:ubuntu /opt/uv "${VIRTUAL_ENV}"

USER ubuntu
WORKDIR /home/ubuntu
RUN uv pip install --no-cache \
    ipywidgets \
    jupyterlab \
    matplotlib \
    nltk \
    notebook \
    numpy \
    pandas \
    Pillow \
    plotly \
    PyYAML \
    ruff \
    scipy \
    scikit-image \
    scikit-learn \
    setuptools \
    sympy \
    seaborn \
    tqdm
