FROM matifali/dockerdl:conda

ARG PYTHON_VER=3.12
# Change to your user
USER ubuntu

# Change Workdir
WORKDIR /home/ubuntu

# Accept conda tos
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# Create deep-learning environment
RUN conda create --name DL --channel conda-forge python=${PYTHON_VER} --yes && conda clean --all --yes

# Make new shells activate the DL environment:
RUN echo "# Make new shells activate the DL environment" >>/home/ubuntu/.bashrc && \
    echo "conda activate DL" >>/home/ubuntu/.bashrc

# Download and install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/home/ubuntu/.cargo/bin:${PATH}"

# Install packages inside the new environment
RUN conda activate DL && uv pip install --upgrade pip && \
    uv pip install --upgrade torch torchvision torchaudio torchtext && \
    uv pip install \
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
    # Set path of python packages
    echo "# Set path of python packages" >>/home/ubuntu/.bashrc && \
    echo 'export PATH=/home/ubuntu/.local/bin:$PATH' >>/home/ubuntu/.bashrc
