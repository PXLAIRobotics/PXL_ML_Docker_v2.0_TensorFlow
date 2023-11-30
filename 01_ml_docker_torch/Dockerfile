FROM pytorch/pytorch:2.1.1-cuda12.1-cudnn8-runtime

# We love UTF!
ENV LANG C.UTF-8
    
RUN set -x \
    && apt-get update \
	&& apt-get install -y git vim tmux nano htop sudo curl wget gnupg2 \
	&& apt-get install -y bash-completion \
    && apt-get install sudo -y

RUN set -x \
    && pip3 install --upgrade setuptools \
    && pip3 install powerline-shell \
    && pip3 install jupyter

# Copy requirements.txt and install the Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir --ignore-installed -r /tmp/requirements.txt

RUN pip3 install PDPbox==0.3.0
RUN pip3 install fastai==2.7.13
RUN pip3 install lightning==2.1.2
RUN pip3 install wandb==0.15.12
RUN pip3 install seaborn==0.13.0
RUN pip3 install pyarrow==13.0.0
RUN pip3 install graphviz==0.20.1
RUN pip3 install treeinterpreter==0.2.3
RUN pip3 install onnx==1.14.1 onnxruntime==1.16.1

RUN pip3 install transformers==4.34.1
RUN pip3 install datasets==2.14.5
RUN pip3 install sentencepiece==0.1.99
RUN pip3 install accelerate==0.23.0

#ARG DEBIAN_FRONTEND=noninteractive
#RUN apt-get install -y graphviz

RUN set -x \
     && apt-get clean && rm -rf /var/lib/apt/lists/* \
	 && useradd -ms /bin/bash user \
	 && echo "user:user" | chpasswd && adduser user sudo \
	 && echo "user ALL=(ALL) NOPASSWD: ALL " >> /etc/sudoers

# RUN pip3 uninstall -y psutil
# RUN pip3 install psutil

USER user
WORKDIR /home/user
RUN mkdir notebooks

RUN git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack  \
        && git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux-resurrect
COPY --chown=user:user ./.tmux.conf /home/user/.tmux.conf
COPY --chown=user:user ./.powerline.sh /home/user/.powerline.sh

#
# Set some decent colors if the container needs to be accessed via /bin/bash.
RUN echo LS_COLORS=$LS_COLORS:\'di=1\;33:ln=36\' >> ~/.bashrc \
        && echo export LS_COLORS >> ~/.bashrc \
        && echo 'source ~/.powerline.sh' >> ~/.bashrc \
        && echo 'alias tmux="tmux -2"' >> ~/.bashrc \
        && echo 'PATH=~/bin:$PATH' >> ~/.bashrc \
        && touch ~/.sudo_as_admin_successful # To surpress the sudo message at run.

CMD sudo service ssh start && /bin/bash
