ARG BASE_IMAGE=matifali/dockerdl-base:latest
FROM ${BASE_IMAGE}
# CUDA 12.6 build from PyTorch's index: shares the CUDA 12 libs with tensorflow[and-cuda]
# (PyPI ships CUDA 13 wheels, which would add a second ~2.5 GB CUDA stack in tf-torch)
RUN uv pip install --no-cache --index https://download.pytorch.org/whl/cu126 --index-strategy unsafe-best-match \
    torch torchvision torchaudio lightning && \
    python -c "import torch, torchvision, torchaudio, lightning"
