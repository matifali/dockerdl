ARG CUDA_VER=13.1.0
ARG UBUNTU_VER=24.04
# Download the base image
FROM nvidia/cuda:${CUDA_VER}-cudnn-runtime-ubuntu${UBUNTU_VER}
# you can check for all available images at https://hub.docker.com/r/nvidia/cuda/tags

# Install as root
USER root

# Shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# miniconda path
ENV CONDA_DIR /opt/miniconda

# conda path
ENV PATH="${CONDA_DIR}/bin:$PATH"

ARG DEBIAN_FRONTEND="noninteractive"
ARG ZELLIJ_VERSION=v0.40.1

# Install dependencies
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
RUN curl -L -o zellij.tar.gz "https://github.com/zellij-org/zellij/releases/download/${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz" && \
    tar -xzf zellij.tar.gz -C /usr/local/bin && \
    rm zellij.tar.gz && \
    zellij --version

ARG TARGETARCH
# Install miniconda
RUN case "${TARGETARCH}" in \
    "amd64") ARCH_SUFFIX="x86_64" ;; \
    "arm64") ARCH_SUFFIX="aarch64" ;; \
    *) echo "Unsupported TARGETARCH: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    curl -fsSL "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-${ARCH_SUFFIX}.sh" -o miniconda.sh && \
    /bin/bash miniconda.sh -b -p "${CONDA_DIR}" && \
    rm -rf miniconda.sh && \
    conda clean --all --yes && \
    # Enable conda autocomplete
    curl -fsSL https://github.com/tartansandal/conda-bash-completion/raw/master/conda -o /etc/bash_completion.d/conda

# Add a user `ubuntu` so that you're not developing as the `root` user
RUN chown -R 1000:1000 ${CONDA_DIR} && \
    echo ". $CONDA_DIR/etc/profile.d/conda.sh" >>/home/ubuntu/.profile

USER ubuntu

WORKDIR /home/ubuntu

# Initilize shell for conda
RUN conda init bash && source /home/ubuntu/.bashrc
