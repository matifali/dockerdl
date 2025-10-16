# DockerDL [![Docker Build](https://github.com/matifali/dockerdl/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/matifali/dockerdl/actions/workflows/docker-publish.yml) ![Docker Pulls](https://img.shields.io/docker/pulls/matifali/dockerdl) <a href='https://hub.docker.com/r/matifali/dockerdl' target="_blank"><img alt='DockerHub' src='https://img.shields.io/badge/DockerHub-100000?logoColor=0000FF&labelColor=0000FF&color=0000FF'/></a>

![DALL·E A wide-screen, imaginative illustration of a whale engaged in machine learning activities, featuring a large container to symbolize Docker](https://github.com/matifali/dockerdl/assets/10648092/1f814829-b28c-4a35-ab0a-8cd01a7fcd44)

## Deep Learning Docker Image

Don't waste time on setting up a deep learning environment while you can get a deep learning environment with everything pre-installed.

## List of Packages installed

- [conda](https://docs.conda.io/en/latest/miniconda.html)
- [Jupyter lab](https://jupyter.org/)
- [Matplotlib](https://matplotlib.org/)
- [NLTK](https://www.nltk.org/)
- [Numpy](https://numpy.org/)
- [Pandas](https://pandas.pydata.org/)
- [Plotly](https://plotly.com/)
- [PyTorch](https://pytorch.org/)
- [Scikit-Learn](https://scikit-learn.org/)
- [Seaborn](https://seaborn.pydata.org/)
- [TensorFlow](https://www.tensorflow.org/)
- [zellij](https://github.com/zellij-org/zellij)

## Image variants and tags

| Variant                      | Tag                  | Conda              | PyTorch            | TensorFlow         | Image size                                                                                                                       |
| ---------------------------- | -------------------- | ------------------ | ------------------ | ------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| Conda                        | `conda`              | :heavy_check_mark: | :x:                | :x:                | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/conda?style=for-the-badge&label=)          |
| Tensorflow                   | `tf`                 | :x:                | :x:                | :heavy_check_mark: | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/tf?style=for-the-badge&label=)             |
| PyTorch                      | `torch`              | :x:                | :heavy_check_mark: | :x:                | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/torch?style=for-the-badge&label=)          |
| PyTorch + Tensorflow         | `tf-torch`, `latest` | :x:                | :heavy_check_mark: | :heavy_check_mark: | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/tf-torch?style=for-the-badge&label=)       |
| PyTorch + Tensorflow + Conda | `tf-torch-conda`     | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/tf-torch-conda?style=for-the-badge&label=) |

You can see the full list of tags [https://hub.docker.com/r/matifali/dockerdl/tags](https://hub.docker.com/r/matifali/dockerdl/tags?page=1&ordering=last_updated).

## Requirements

1. [Docker](https://docs.docker.com/engine/install/)
2. [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) [^1]
3. Linux, or Windows with [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)

## Fast Start

```shell
docker run --gpus all --rm -it -h dockerdl matifali/dockerdl bash
```

### JupyterLab server without conda

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

The following `--build-arg` are available for the `dockerdl-base` image.

| Argument     | Description    | Default   | Possible Values           |
| ------------ | -------------- | --------- | ------------------------- |
| `USERNAME`   | User name      | `coder`   | Any string or `$USER`     |
| `USERID`     | User ID        | `1000`    | `$(id -u $USER)`          |
| `GROUPID`    | Group ID       | `1000`    | `$(id -g $USER)`          |
| `CUDA_VER`   | CUDA version   | `12.6.1`  |                           |
| `UBUNTU_VER` | Ubuntu version | `24.04`   | `24.04`, `22.04`, `20.04` |

> [!WARNING]
> **Not all combinations of `--build-arg` are tested.**

#### Step 1

Build the base image

```shell
docker build -t dockerdl-base:latest --build-arg USERNAME=coder --build-arg CUDA_VER=12.4.1 --build-arg UBUNTU_VER=22.04 -f base.Dockerfile .
```

#### Step 2

Build the image you want with the base image as the base image.

```shell
docker build -t dockerdl:tf --build-arg TF_VERSION=2.12.0 -f tf.Dockerfile .
```

or

```shell
docker build -t dockerdl:torch --build-arg -f torch.Dockerfile .
```

## How to connect

### VS Code

1. Install [vscode](https://code.visualstudio.com/Download).
2. Install the following extensions:
    1. [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker).
    2. [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python).
    3. [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
4. Follow the instructions [here](https://code.visualstudio.com/docs/remote/containers#_quick-start-open-an-existing-folder-in-a-container).

### Coder

1. Install Coder. (<https://github.com/coder/coder>).
2. Use deeplearning template which references these images (<https://github.com/matifali/coder-templates/tree/main/deeplearning>).

### JetBrains PyCharm Professional

Follow the instructions [here](https://www.jetbrains.com/help/pycharm/using-docker-as-a-remote-interpreter.html).

## Issues

If you find any issue please feel free to create an [issue](https://github.com/matifali/dockerdL/issues/new/choose) and submit a PR.

## Support

- Give a star (⭐) if using this has helped you.
- [![Sponsor matifali](https://img.shields.io/badge/Sponsor-matifali-blue)](https://github.com/sponsors/matifali)
  
## References

[^1]: This image is based on [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda) and uses [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) to access the GPU.
