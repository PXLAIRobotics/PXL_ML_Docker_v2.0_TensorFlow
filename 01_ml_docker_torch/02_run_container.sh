#!/bin/bash

# Check if nvidia-smi command exists
if command -v nvidia-smi &> /dev/null; then
    # Check if the output of nvidia-smi -L has at least 1 line
    if [[ $(nvidia-smi -L | wc -l) -ge 1 ]]; then
        echo "CUDA is present."
        # Your Docker command for when CUDA is available
        docker run -it --rm \
            --name pxl_ml_container \
            --hostname pxl_ml_container \
            --env="DISPLAY" \
            --env="QT_X11_NO_MITSHM=1" \
            --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
            -v `pwd`/../commands/bin:/home/user/bin \
            -v `pwd`/../notebooks:/home/user/notebooks \
            -v `pwd`/../data:/home/user/data \
            -v `pwd`/../app:/home/user/app \
            -env="XAUTHORITY=$XAUTH" \
            --volume="$XAUTH:$XAUTH" \
            --gpus all \
            -p 7777:7777 \
            -p 8080:8080 \
            -p 5000:5000 \
            pxl_ml_image_torch:latest \
            bash
    else
        echo "CUDA is not present."
        # Your Docker command for when CUDA is not available
        docker run --privileged -it --rm \
            --name pxl_ml_container \
            --hostname pxl_ml_container \
            --volume=/tmp/.X11-unix:/tmp/.X11-unix \
            -v `pwd`/../commands/bin:/home/user/bin \
            -v `pwd`/../notebooks:/home/user/notebooks \
            -v `pwd`/../data:/home/user/data \
            -v `pwd`/../app:/home/user/app \
            --device=/dev/dri:/dev/dri \
            --env="DISPLAY=$DISPLAY" \
            -e "TERM=xterm-256color" \
            --cap-add SYS_ADMIN --device /dev/fuse \
            -p 7777:7777 \
            -p 8080:8080 \
            -p 5000:5000 \
            pxl_ml_image_torch:latest \
            bash
    fi
else
    echo "nvidia-smi command does not exist."
    # Your Docker command for when nvidia-smi command doesn't exist
    docker run --privileged -it --rm \
        --name pxl_ml_container \
        --hostname pxl_ml_container \
        --volume=/tmp/.X11-unix:/tmp/.X11-unix \
        -v `pwd`/../commands/bin:/home/user/bin \
        -v `pwd`/../notebooks:/home/user/notebooks \
        -v `pwd`/../data:/home/user/data \
        -v `pwd`/../app:/home/user/app \
        --device=/dev/dri:/dev/dri \
        --env="DISPLAY=$DISPLAY" \
        -e "TERM=xterm-256color" \
        --cap-add SYS_ADMIN --device /dev/fuse \
        -p 7777:7777 \
        -p 8080:8080 \
        -p 5000:5000 \
        pxl_ml_image_torch:latest \
        bash
fi
