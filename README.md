# DockerDL [![Docker Build](https://github.com/matifali/dockerdl/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/matifali/dockerdl/actions/workflows/docker-publish.yml) ![Docker Pulls](https://img.shields.io/docker/pulls/matifali/dockerdl) <a href='https://hub.docker.com/r/matifali/dockerdl' target="_blank"><img alt='DockerHub' src='https://img.shields.io/badge/DockerHub-100000?logoColor=0000FF&labelColor=0000FF&color=0000FF'/></a>

## Deep Learning Docker Image

Don't waste time on setting up a deep learning environment while you can get a deep learning environment with everything pre-installed.

## List of Packages installed

- [TensorFlow](https://www.tensorflow.org/)
- [PyTorch](https://pytorch.org/)
- [Numpy](https://numpy.org/)
- [Scikit-Learn](https://scikit-learn.org/)
- [Pandas](https://pandas.pydata.org/)
- [Matplotlib](https://matplotlib.org/)
- [Seaborn](https://seaborn.pydata.org/)
- [Plotly](https://plotly.com/)
- [NLTK](https://www.nltk.org/)
- [Jupyter notebook/lab](https://jupyter.org/)
- [conda](https://docs.conda.io/en/latest/miniconda.html)
- [mamba](https://github.com/mamba-org/mamba) (faster than conda) [^1]

## Image variants and tags

| Variant                      | Tag                  | Conda              | PyTorch            | TensorFlow         | Image size                                                                                                                        |
| ---------------------------- | -------------------- | ------------------ | ------------------ | ------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| Conda                        | `conda`              | :heavy_check_mark: | :x:                | :x:                | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/conda-base?style=for-the-badge&label=)      |
| Tensorflow                   | `tf`                 | :x:                | :x:                | :heavy_check_mark: | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/tensorflow?style=for-the-badge&label=)      |
| PyTorch                      | `torch`              | :x:                | :heavy_check_mark: | :x:                | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/pytorch?style=for-the-badge&label=)         |
| PyTorch Nightly              | `torch-nightly`      | :x:                | :heavy_check_mark: | :x:                | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/pytorch-nightly?style=for-the-badge&label=) |
| PyTorch + Tensorflow         | `tf-torch`, `latest` | :x:                | :heavy_check_mark: | :heavy_check_mark: | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/no-conda?style=for-the-badge&label=)        |
| PyTorch + Tensorflow + Conda | `tf-torch-conda`     | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/matifali/dockerdl/conda?style=for-the-badge&label=)           |

You can see the full list of tags [https://hub.docker.com/r/matifali/dockerdl/tags](https://hub.docker.com/r/matifali/dockerdl/tags?page=1&ordering=last_updated).

## Requirements

1. [Docker](https://docs.docker.com/engine/install/)
2. [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) [^2]
3. Linux, MacOS, or Windows with [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)

## Fast Start

```console
docker run --gpus all --rm -it -h dockerdl matifali/dockerdl bash
```

### Launch a vscode server

```console
docker run --gpus all --rm -it -h dockerdl -p 8000:8000 matifali/dockerdl code-server --accept-server-license-terms serve-local --without-connection-token --quality stable --telemetry-level off
```

Connect to the server using your browser at [http://localhost:8000](http://localhost:8000).

### Launch a Jupyter notebook server

```console
docker run --gpus all --rm -it -h dockerdl -p 8888:8888 matifali/dockerdl jupyter notebook --no-browser --port 8888 --NotebookApp.token='' --ip='*'
```

### JupyterLab server without conda

```console
docker run --gpus all --rm -it -h dockerdl -p 8888:8888 matifali/dockerdl jupyter lab --no-browser --port 8888 --ServerApp.token='' --ip='*'
```

Connect by opening <http://localhost:8888> in your browser.

## Build your own

### Clone the repo

```console
git clone https://github.com/matifali/dockerdl.git
```

### Add or delete packages

Modify the corresponding [`Dockerfile`] to add or delete packages.

### Build

Following `--build-arg` are available:

| Argument   | Description        | Default | Possible Values           |
| ---------- | ------------------ | ------- | ------------------------- |
| USERNAME   | User name          | coder   | Any string or `$USER`     |
| USERID     | User ID            | 1000    | `$(id -u $USER)`          |
| GROUPID    | Group ID           | 1000    | `$(id -g $USER)`          |
| PYTHON_VER | Python version     | 3.10    | 3.10, 3.9, 3.8            |
| CUDA_VER   | CUDA version       | 11.8.0  | 11.7.0, 11.8.0 etc.       |
| UBUNTU_VER | Ubuntu version     | 22.04   | 22.04, 20.04, 18.04       |
| TF_VERSION | TensorFlow version | latest  | any version from Pypi[^3] |

> Note: **Not all combinations of `--build-arg` are tested.**

#### Example 1

Build an image with default settings and your own username and user id.

```console
docker build -t dockerdl:latest /
--build-arg USERNAME=$USER /
--build-arg USERID=$(id -u $USER) /
--build-arg GROUPID=$(id -g $USER) /
-f conda.Dockerfile .
```

#### Example 2

Build an image with Python 3.8, TensorFlow 2.6.0, CUDA 11.5.0, Ubuntu 20.04 and no:conda

```console
docker build -t dockerdl:latest /
--build-arg USERNAME=$USER /
--build-arg USERID=$(id -u $USER) /
--build-arg GROUPID=$(id -g $USER) /
--build-arg PYTHON_VER=3.8 /
--build-arg CUDA_VER=11.5.0 /
--build-arg UBUNTU_VER=20.04 /
--build-arg TF_VERSION=2.6.0 /
-f noconda.Dockerfile .
```

## How to connect

### JetBrains PyCharm Professional

Follow the instructions [here](https://www.jetbrains.com/help/pycharm/docker.html).

### VS Code

1. install [vscode](https://code.visualstudio.com/Download).
2. Install [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) extension.
3. Install [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) extension.
4. install [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension.
5. Follow the instructions [here](https://code.visualstudio.com/docs/remote/containers#_quick-start-open-an-existing-folder-in-a-container).

## Issues

If you find any issue please feel free to create an [issue](https://github.com/matifali/dockerdL/issues/new/choose) and submit a PR.

## Support

- Please give a star (⭐) if using this has helped you.
- Help the flood victims in Pakistan by donating [here](https://alkhidmat.org/).

## References

[^1]: [mamba](https://mamba.readthedocs.io/en/latest/user_guide/mamba.html) is a fast, drop-in replacement for the conda package manager. It is written in C++ and uses the same package format as conda. It is designed to be a drop-in replacement for conda, and can be used as a drop-in replacement for the conda command line client.
[^2]: This image is based on [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda) and uses [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) to access the GPU.
[^3]: [Pypi](https://pypi.org) is the Python Package Index. It is a repository of software for the Python programming language.
