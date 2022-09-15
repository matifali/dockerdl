# Build argumnets
ARG CUDA_VER=11.7
ARG UBUNTU_VER=22.04

# Download the base image
FROM nvidia/cuda:${CUDA_VER}.1-devel-ubuntu${UBUNTU_VER} 
# you can check for all available images at https://hub.docker.com/r/nvidia/cuda/tags

# Install as root
USER root

# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]

# Install dependencies
ARG DEBIAN_FRONTEND="noninteractive"
ARG USERNAME=coder
ARG USERID=1000
ARG GROUPID=1000
RUN apt-get update && \
    apt-get upgrade -y && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    $APT_INSTALL \
    bash \
    bash-completion \
    ca-certificates \
    cmake \
    curl \
    git \
    htop \
    libcudnn8 \
    libopenblas-dev \
    linux-headers-$(uname -r) \
    nano \
    openssh-client \
    python3 python3-dev python3-pip python-is-python3 \
    sudo \
    unzip \
    vim \
    wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    # Add a user `${USERNAME}` so that you're not developing as the `root` user
    groupadd -g ${GROUPID} ${USERNAME} && \
    useradd ${USERNAME} \
    --create-home \
    --uid ${USERID} \
    --gid ${GROUPID} \
    --shell=/bin/bash && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
    
# Change to your user
USER ${USERNAME}

# Chnage Workdir
WORKDIR /home/${USERNAME}

# Put conda in path so we can use conda activate
ENV PATH=/home/${USERNAME}/miniconda/bin:$PATH

# Install miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /home/${USERNAME}/miniconda.sh && \
    /bin/bash /home/${USERNAME}/miniconda.sh -b -p /home/${USERNAME}/miniconda && \
    rm -rf /home/${USERNAME}/miniconda.sh && \
    echo ". /home/${USERNAME}/miniconda/etc/profile.d/conda.sh" >> /home/${USERNAME}/.profile && \
    # Initialize and update conda
    conda init bash && \
    # Enable bash-completion
    sudo wget --quiet https://github.com/tartansandal/conda-bash-completion/raw/master/conda -P /etc/bash_completion.d/ && \
    # Create deep-learning environment
    conda install mamba -n base -c conda-forge && \
    mamba init && \
    source /home/${USERNAME}/.bashrc && \
    mamba update --name base --channel conda-forge conda && \
    mamba create --name DL --channel conda-forge python=3.10 --yes && \
    mamba clean -a -y && \
    # Make new shells activate the DL environment:
    echo "# Make new shells activate the DL environment" >> /home/${USERNAME}/.bashrc && \
    echo "conda activate DL" >> /home/${USERNAME}/.bashrc
    
# Set --build-arg TF_PACKAGE_VERSION=1.11.0rc0 to install a specific version.
# Installs the latest version by default.
ARG TF_PACKAGE_VERSION=

# Set --build--arg PYTORCH_PIP_URL=https://download.pytorch.org/whl/cu116 to install a specefic version
# installs the latest availble version by default
ARG PYTORCH_PIP_URL=https://download.pytorch.org/whl/cu116

# Install packages inside the new environment
RUN conda activate DL && \	
    PIP_INSTALL="pip install --upgrade --no-cache-dir" && \
    $PIP_INSTALL pip && \
    $PIP_INSTALL pybind11 scikit-build && \
    $PIP_INSTALL torch torchvision torchaudio torchtext --extra-index-url ${PYTORCH_PIP_URL} && \
    $PIP_INSTALL \
    Cython \
    intel-openmp \
    ipywidgets \
    jupyterlab \
    matplotlib \
    mkl \
    nltk \
    notebook \
    numpy \
    pandas \
    Pillow \
    plotly \
    pytest \
    PyYAML \
    scipy \
    scikit-image \
    scikit-learn \
    sympy \
    seaborn \
    tensorflow${TF_PACKAGE_VERSION:+==${TF_PACKAGE_VERSION}} \
    tqdm \
    wheel \
    && \
    pip cache purge && \
    # Set path of python packages
    echo "# Set path of python packages" >> /home/${USERNAME}/.bashrc && \
    echo 'export PATH=$HOME/.local/bin:$PATH' >> /home/${USERNAME}/.bashrc
