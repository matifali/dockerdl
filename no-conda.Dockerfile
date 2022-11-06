# Build argumnets
ARG CUDA_VER=11.7.1
ARG UBUNTU_VER=22.04
# Download the base image
FROM nvidia/cuda:${CUDA_VER}-cudnn8-runtime-ubuntu${UBUNTU_VER}
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
RUN apt-get update && \
apt-get install -y --no-install-recommends \
bash \
bash-completion \
ca-certificates \
curl \
git \
htop \
nano \
openssh-client \
python${PYTHON_VER} python${PYTHON_VER}-dev python3-pip python-is-python3 \
sudo \
unzip \
vim \
wget \ 
zip && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Add a user `${USERNAME}` so that you're not developing as the `root` user
RUN groupadd -g ${GROUPID} ${USERNAME} && \
useradd ${USERNAME} \
--uid=1000 \
--create-home \
--uid ${USERID} \
--gid ${GROUPID} \
--shell=/bin/bash && \
echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd

# Change to your user
USER ${USERNAME}
# Chnage Workdir
WORKDIR /home/${USERNAME}
# Tensorflow Package version passed as build argument e.g. --build-arg TF_VERSION=2.9.2
# A blank value will install the latest version
ARG TF_VERSION=
# Install packages inside the new environment
RUN pip install --upgrade --no-cache-dir pip setuptools wheel && \
pip install --upgrade --no-cache-dir torch torchvision torchaudio && \
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
tensorflow${TF_VERSION:+==${TF_VERSION}} \
tqdm && \
pip cache purge && \
# Set path of python packages
echo "# Set path of python packages" >>/home/${USERNAME}/.bashrc && \
echo 'export PATH=$HOME/.local/bin:$PATH' >>/home/${USERNAME}/.bashrc
