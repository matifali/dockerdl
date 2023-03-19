FROM matifali/dockerdl-base:latest
# Install as user 1000
USER 1000
# Shell
SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]
# Install pytorch nightly
RUN pip install --upgrade --no-cache-dir --pre torch torchvision torchaudio torchtext --force-reinstall --extra-index-url https://download.pytorch.org/whl/nightly/cu118 && \
    pip cache purge