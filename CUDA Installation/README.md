# installatie van nvidia drivers & cuda & nvidia-docker  

## removing drivers  

``sudo apt update && sudo apt upgrade``  
``sudo apt autoremove nvidia* --purge``  

## install nvidia driver  
*show all drivers*  
``ubuntu-drivers devices``  
*NOT needed but can fix problems*  
``sudo ubuntu-drivers autoinstall``  
*fill in with latest driver from 'show all drivers'*  
``sudo apt install nvidia-driver-<version>``  

*reboot is needed*  
``reboot``  

*change the default gpu to Nvidia*  
``sudo prime-select nvidia``  

*reboot is needed*  
``reboot``  

*check if gpu is used (the OFF is fine)*  
``nvidia-smi``  

## install cuda toolkit  
``sudo apt update && sudo apt upgrade``  

``sudo apt install nvidia-cuda-toolkit``  

``nvcc --version``  

## install nvidia-docker  
``curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && \
    sudo apt-get update``  
    
``sudo apt-get install -y nvidia-container-toolkit``  

``sudo nvidia-ctk runtime configure --runtime=docker``  

``sudo systemctl restart docker``  




