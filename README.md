# PXL ML Docker v2.0
 This repository contains the necessary elements (code and artifacts) to build a
 Machine Learning container suitable to execute all the ML exercises of the AnR
 course.
 
The container is equipped with a few development tools such as vim, tmux, git,
... in order to process and analyse (a.k.a. engineer) data and to diagnose any
issue.

!!! Note: Do not clone this repository into a path containing a space !!!*

## Docker Container Specifications

### Base Environment

- Ubuntu: 22.04
- Python: 3.11
- CUDA: 11.5

### Libraries

#### Neural Network Libraries

- Tensorflow / Keras: 2.14
- PyTorch: v2.0.1
- Lightning: 2.0.9
- FastAI: 2.7.12

#### Machine Learning Libraries

- scikitlearn: 1.3.1
- statsmodels: 0.14.0
- prophet: 1.1.5
- ...

#### Visualization Libraries

- matplotlib: 3.8.0
- plotly: 5.17.0
- ggplot: 0.11.5
- ...

#### Deployment Libraries

- flask: 3.0.0
- fastapi: 0.103.2
- ... and much more

_**Note**: This is just a snapshot of the libraries included. There are many more utilities and libraries embedded within the container._


## Prerequisites
* A UNIX-like operating system, preferably Linux. (Ubuntu 20.04+ is recommended.)
* 24GB free space (yes, we know)
* The `glxinfo` command. (It's included with the `mesa-utils` package on Ubuntu. So, install this on the Linux host before building this repository. On an Ubuntu host, execute `sudo apt install mesa-utils` to install `glxinfo`.)
* An operational docker daemon.
* Standard Bash knowledge.

### GPU
You can run the container without GPU support, but your performance (with Deep Learning frameworks) will be low.

**Nvidia**

If you have an Nvidia graphics card capable of running hardware accelerated graphics, follow the instructions in the guide [here](CUDA%20Installation) to install all the necessary drivers, CUDA and the Nvidia docker toolkit. 

You can test GPU support by executing the following steps:

```
003_start_pxl_ml_container.sh
```

```
nvidia-smi
```

```
start_jupyter
```

Open the TestGPU.ipynb notebook and exectute the different steps.
 
## How to build the container
A bash script is provided to build the container, it can be executed by entering
the following command:

```
./001_build_images.sh
```

## How to start the container
To start the container execute the script below:

```
003_start_pxl_ml_container.sh
```
This script will check the available GPU and start the container accordingly.

To use multiple bash shells in the container, It's advised to either work with
`tmux` or execute the script with prefix `005` from the host:

```
./005_attach_bash_to_ml_container.sh
```

## Start jupyter
To start jupyter notebooks, you can use the command
```
start_jupyter
```
inside the container.

## Prebuilt image
You can find a prebuilt version of the image [right here](https://drive.google.com/drive/folders/1KqxEocjVeOtsky2f2vomWljWc7ir1reJ?usp=sharing).

Use `docker load --input anr_ml_image.tar` to import it.
