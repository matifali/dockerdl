# Build arguments
ARG CUDA_VER=12.4.1
ARG UBUNTU_VER=22.04
# Download the base image
FROM nvidia/cuda:${CUDA_VER}-cudnn-runtime-ubuntu${UBUNTU_VER}
# you can check for all available images at https://hub.docker.com/r/nvidia/cuda/tags
# Install as root
USER root
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
# Python version
ARG PYTHON_VER=3.10
# Install dependencies
ARG DEBIAN_FRONTEND="noninteractive"
ARG USERNAME=coder
ARG USERID=1000
ARG GROUPID=1000
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    bash-completion \
    ca-certificates \
    curl \
    git \
    htop \
    nano \
    nvidia-modprobe \
    openssh-client \
    python${PYTHON_VER} python${PYTHON_VER}-dev python3-pip python-is-python3 \
    sudo \
    tmux \
    unzip \
    vim \
    wget \ 
    zip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the installed PYTHON_VER as the default python version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VER} 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VER} 1

# Expose port 8000 for code-server
EXPOSE 8000

# Add a user `${USERNAME}` so that you're not developing as the `root` user
RUN groupadd -g ${GROUPID} ${USERNAME} && \
    useradd ${USERNAME} \
    --create-home \
    --uid ${USERID} \
    --gid ${GROUPID} \
    --shell=/bin/bash && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd

# Change to your user
USER ${USERNAME}
# Chnage Workdir
WORKDIR /home/${USERNAME}
# Install packages inside the new environment
RUN pip install --upgrade --no-cache-dir pip setuptools wheel && \
    pip install --upgrade --no-cache-dir \
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
    scipy \
    scikit-image \
    scikit-learn \
    sympy \
    seaborn \
    tqdm && \
    pip cache purge && \
    # Set path of python packages
    echo "# Set path of python packages" >>/home/${USERNAME}/.bashrc && \
    echo 'export PATH=$HOME/.local/bin:$PATH' >>/home/${USERNAME}/.bashrc
