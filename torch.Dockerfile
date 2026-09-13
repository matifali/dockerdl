ARG BASE_IMAGE=matifali/dockerdl-base:latest
FROM ${BASE_IMAGE}
RUN uv pip install --no-cache torch torchvision torchaudio lightning && \
    python -c "import torch, torchvision, torchaudio, lightning"
