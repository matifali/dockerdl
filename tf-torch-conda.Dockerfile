FROM matifali/dockerdl:conda

ARG PYTHON_VER=3.10
# Change to your user
USER 1000

# Change Workdir
WORKDIR ${HOME}

# Create deep-learning environment
RUN conda create --name DL --channel conda-forge python=${PYTHON_VER} --yes && conda clean --all --yes

# Make new shells activate the DL environment:
RUN echo "# Make new shells activate the DL environment" >>${HOME}/.bashrc && \
    echo "conda activate DL" >>${HOME}/.bashrc

# Tensorflow Package version passed as build argument e.g. --build-arg TF_VERSION=2.9.2
# A blank value will install the latest version
ARG TF_VERSION=

# Install packages inside the new environment
RUN conda activate DL && pip install --upgrade --no-cache-dir pip && \
    pip install --upgrade --no-cache-dir torch torchvision torchaudio torchtext --index-url https://download.pytorch.org/whl/cu118 && \
    pip install --upgrade --no-cache-dir \
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
    pip cache purge && \
    # Set path of python packages
    echo "# Set path of python packages" >>${HOME}/.bashrc && \
    echo 'export PATH=$HOME/.local/bin:$PATH' >>${HOME}/.bashrc
