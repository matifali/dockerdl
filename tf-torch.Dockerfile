ARG BASE_IMAGE=matifali/dockerdl-base:latest
FROM ${BASE_IMAGE}
# Tensorflow Package version passed as build argument e.g. --build-arg TF_VERSION=2.21.0
# A blank value will install the latest version
ARG TF_VERSION=
# CUDA 12.6 build from PyTorch's index so torch and TF share one CUDA 12 stack
RUN uv pip install --no-cache --index https://download.pytorch.org/whl/cu126 --index-strategy unsafe-best-match \
    torch torchvision torchaudio lightning "tensorflow[and-cuda]${TF_VERSION:+==${TF_VERSION}}" && \
    python -c "import torch, torchvision, torchaudio, lightning, tensorflow"
# Don't let TF pre-allocate all GPU memory; matters with several kernels or torch alongside
ENV TF_FORCE_GPU_ALLOW_GROWTH=true
