ARG BASE_IMAGE=matifali/dockerdl:conda
FROM ${BASE_IMAGE}

ARG PYTHON_VER=3.12
USER ubuntu
WORKDIR /home/ubuntu

# Shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Accept conda tos
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# Create deep-learning environment
RUN conda create --name DL --channel conda-forge python="${PYTHON_VER}" --yes && conda clean --all --yes

# Make new shells activate the DL environment:
RUN echo "# Make new shells activate the DL environment" >>/home/ubuntu/.bashrc && \
    echo "conda activate DL" >>/home/ubuntu/.bashrc

# Download and install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/home/ubuntu/.cargo/bin:${PATH}"

# Install packages inside the new environment
RUN . /opt/miniconda/etc/profile.d/conda.sh && \
    conda activate DL && uv pip install --no-cache --upgrade pip && \
    uv pip install --no-cache --upgrade torch torchvision torchaudio torchtext && \
    uv pip install --no-cache \
    ipywidgets \
    jupyterlab \
    lightning \
    matplotlib \
    nltk \
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
    conda clean --all --yes && \
    find /opt/miniconda/envs/DL/lib/python3.* -name '__pycache__' -exec rm -rf {} + && \
    # Set path of python packages
    echo "# Set path of python packages" >>/home/ubuntu/.bashrc && \
    echo 'export PATH=/home/ubuntu/.local/bin:$PATH' >>/home/ubuntu/.bashrc
