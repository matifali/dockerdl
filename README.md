# DockerDL  [![Docker](https://github.com/matifali/DockerDL/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/matifali/DockerDL/actions/workflows/docker-publish.yml)

Deep Learning Docker Image

Don't waste time on setting up a deep learning env while you can get a deep learning environmnet with everything pre-insatlled.
This image uses **[mamba](https://mamba.readthedocs.io/en/latest/user_guide/mamba.html)**[^1] to create an environment named **DL** and then install most of the packages using pip

## Requirements
1. [Docker](https://docs.docker.com/engine/install/)
2. [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## Fast Start
```console
docker run --gpus all --rm -it -h dockerdl ghcr.io/matifali/dockerdl:main bash
```
Optionally launch a Jupyter notebook server
```console
docker run --gpus all --rm -it -h dockerdl -p 8888:8888 ghcr.io/matifali/dockerdl:main 
jupyter notebook --no-browser --port 8888 --NotebookApp.token='' --ip='*'
```

Or a JupyterLab server
```console
docker run --gpus all --rm -it -h dockerdl -p 8888:8888 ghcr.io/matifali/dockerdl:main
jupyter lab --no-browser --port 8888 --ServerApp.token='' --ip='*'
```

## Build your own

### Clone the repo

```console
git clone https://github.com/matifali/DockerDL.git
```

### Add or delete packages

modify `[Dockerfile](https://github.com/matifali/DockerDL/blob/main/Dockerfile)` to add or delete packages.

### Build
```console
docker build -t dockerdl:latest /
--build-arg USERNAME=$USER /
--build-arg USERID=$(id -u $USER) /
--build-arg GROUPID=$(id -g $USER) /
.
```
### Run
```console
docker run --gpus all --rm -it -h dockerdl dockerdl:latest bash
```
Optionally launch a Jupyter notebook server
```console
docker run --gpus all --rm -it -h dockerdl -p 8888:8888 dockerdl:latest
jupyter notebook --no-browser --port 8888 --NotebookApp.token='' --ip='*'
```

Or a JupyterLab server
```console
docker run --gpus all --rm -it -h dockerdl -p 8888:8888 dockerdl:latest
jupyter lab --no-browser --port 8888 --ServerApp.token='' --ip='*'
```

## Issues

If you find any issue please feel free to create an [issue](https://github.com/matifali/DockerDL/issues/new/choose) and submit a PR.

## Support

* Please give a star (⭐) if using this has helped you.
* Help the flood victims in Pakistan by donating [here](https://alkhidmat.org/)

[^1]: mamba is a faster conda package manager
