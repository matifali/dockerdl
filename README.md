# DockerDL [![Docker Build](https://github.com/matifali/dockerdl/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/matifali/dockerdl/actions/workflows/docker-publish.yml) ![Docker Pulls](https://img.shields.io/docker/pulls/matifali/dockerdl) <a href='https://hub.docker.com/r/matifali/dockerdl' target="_blank"><img alt='DockerHub' src='https://img.shields.io/badge/DockerHub-100000?logoColor=0000FF&labelColor=0000FF&color=0000FF'/></a>

![DALL·E A wide-screen, imaginative illustration of a whale engaged in machine learning activities, featuring a large container to symbolize Docker](https://github.com/matifali/dockerdl/assets/10648092/1f814829-b28c-4a35-ab0a-8cd01a7fcd44)

## Deep Learning Docker Image

Don't waste time on setting up a deep learning environment while you can get a deep learning environment with everything pre-installed.

## List of Packages installed

- [Jupyter lab](https://jupyter.org/)
- [Lightning](https://lightning.ai/) (PyTorch images)
- [Matplotlib](https://matplotlib.org/)
- [NLTK](https://www.nltk.org/)
- [Numpy](https://numpy.org/)
- [Pandas](https://pandas.pydata.org/)
- [Plotly](https://plotly.com/)
- [PyTorch](https://pytorch.org/)
- [ruff](https://docs.astral.sh/ruff/)
- [Scikit-Image](https://scikit-image.org/)
- [Scikit-Learn](https://scikit-learn.org/)
- [SciPy](https://scipy.org/)
- [Seaborn](https://seaborn.pydata.org/)
- [TensorFlow](https://www.tensorflow.org/)
- [uv](https://github.com/astral-sh/uv)
- [zellij](https://github.com/zellij-org/zellij)

## Image variants and tags

| Variant              | Tag                  | PyTorch            | TensorFlow         | Image size                                                                                                                 |
| -------------------- | -------------------- | ------------------ | ------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| Tensorflow           | `tf`                 | :x:                | :heavy_check_mark: | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/tf?style=for-the-badge&label=)       |
| PyTorch              | `torch`              | :heavy_check_mark: | :x:                | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/torch?style=for-the-badge&label=)    |
| PyTorch + Tensorflow | `tf-torch`, `latest` | :heavy_check_mark: | :heavy_check_mark: | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/tf-torch?style=for-the-badge&label=) |

All images use a [uv](https://docs.astral.sh/uv/)-managed Python 3.13 in `/opt/venv` on Ubuntu 26.04. CUDA 12.6 and cuDNN come from the PyTorch and TensorFlow pip wheels, so the only host requirement is an NVIDIA driver that supports CUDA 12 (>= 525). The `conda` and `tf-torch-conda` tags are no longer built; the last conda-based images remain on Docker Hub.

You can see the full list of tags [https://hub.docker.com/r/matifali/dockerdl/tags](https://hub.docker.com/r/matifali/dockerdl/tags?page=1&ordering=last_updated).

## Requirements

1. [Docker](https://docs.docker.com/engine/install/)
2. [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) [^1]
3. Linux, or Windows with [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)

## Fast Start

```shell
docker run --gpus all --rm -it -h dockerdl matifali/dockerdl bash
```

### JupyterLab server

```shell
docker run --gpus all --rm -it -h dockerdl -p 8888:8888 matifali/dockerdl jupyter lab --no-browser --port 8888 --ServerApp.token='' --ip='*'
```

Connect by opening <http://localhost:8888> in your browser.

## Customize the image

### Clone the repo

```shell
git clone https://github.com/matifali/dockerdl.git
```

### Add or delete packages

Modify the corresponding `[Dockerfile]` to add or delete packages.

> [!NOTE]
> You may have to rebuild the `dockerdl-base` if you are building a custom image and then use it as a base image. See [Build](#build) section.

### Build

The base image is plain `ubuntu`; edit the `FROM` line in `base.Dockerfile` to change it. The CUDA version is chosen by the pip wheels: PyTorch comes from the `cu126` index (`torch.Dockerfile`, `tf-torch.Dockerfile`) and TensorFlow's `[and-cuda]` extra pulls matching CUDA 12 libraries.

Python is installed by [uv](https://docs.astral.sh/uv/) into `/opt/venv` (owned by the `ubuntu` user, so `uv pip install <pkg>` works without sudo). Pick the version with `--build-arg PYTHON_VER=3.13` (default; the newest version TensorFlow ships wheels for).

#### Step 1

Build the base image

```shell
docker build -t dockerdl-base:latest -f base.Dockerfile .
```

#### Step 2

Build the image you want with the base image as the base image.

```shell
docker build -t dockerdl:tf --build-arg BASE_IMAGE=dockerdl-base:latest --build-arg TF_VERSION=2.21.0 -f tf.Dockerfile .
```

or

```shell
docker build -t dockerdl:torch --build-arg BASE_IMAGE=dockerdl-base:latest -f torch.Dockerfile .
```

## How to connect

### VS Code

1. Install [vscode](https://code.visualstudio.com/Download).
2. Install the following extensions:
    1. [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker).
    2. [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python).
    3. [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
3. Follow the instructions [here](https://code.visualstudio.com/docs/remote/containers#_quick-start-open-an-existing-folder-in-a-container).

### Coder

1. Install Coder. (<https://github.com/coder/coder>).
2. Use deeplearning template which references these images (<https://github.com/matifali/coder-templates/tree/main/deeplearning>).

### JetBrains PyCharm Professional

Follow the instructions [here](https://www.jetbrains.com/help/pycharm/using-docker-as-a-remote-interpreter.html).

## Issues

If you find any issue please feel free to create an [issue](https://github.com/matifali/dockerdl/issues/new/choose) and submit a PR.

## Support

- Give a star (⭐) if using this has helped you.
- [![Sponsor matifali](https://img.shields.io/badge/Sponsor-matifali-blue)](https://github.com/sponsors/matifali)
  
## References

[^1]: CUDA and cuDNN libraries come from the PyTorch/TensorFlow pip wheels; [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) mounts the host driver, `nvidia-smi` and `libnvidia-ml` into the container.
