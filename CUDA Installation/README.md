# Nvidia drivers, CUDA & Nvidia-docker installation

## Ubuntu/Debian

Only perform steps 1 and 2 if you already have old drivers, or if the drivers you have are malfunctioning. 

### 1. Remove (old) drivers  

```
sudo apt update && sudo apt upgrade
```

```
sudo apt autoremove nvidia* --purge
```
  
### 2. Install nvidia driver  
Show all drivers  
```
ubuntu-drivers devices
```
  
NOT needed but can fix problems  
```
sudo ubuntu-drivers autoinstall
```
  
Fill in with latest driver from 'show all drivers'  
```
sudo apt install nvidia-driver-<version>
```
  
Reboot is needed  
```
sudo reboot
```
  
Change the default gpu to Nvidia  
```
sudo prime-select nvidia
```
  
Reboot is needed  
```
sudo reboot
```
  
Check if gpu is used (the OFF is fine)  
```
nvidia-smi
```
  
### 3. Install cuda toolkit  

Definitely:

```
sudo apt update
```

Maybe (this has the potential to break something with the Nvidia driver):

```
sudo apt upgrade
```
  

```
sudo apt install nvidia-cuda-toolkit
```
  

```
nvcc --version
```
  
## 4. Install nvidia-docker  
```
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && \
    sudo apt-get update
```
  
    
```
sudo apt-get install -y nvidia-container-toolkit
```
  

```
sudo nvidia-ctk runtime configure --runtime=docker
```
  

```
sudo systemctl restart docker
```
  
### 5. (optional) Test everything
```
docker run --rm --runtime=nvidia --gpus all nvidia/cuda:11.5.2-devel-ubuntu20.04 nvidia-smi
```

_**Note**: you can delete this image later, using_
```
docker image rm nvidia/cuda:11.5.2-devel-ubuntu20.04
```
