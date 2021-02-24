FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

ARG DOCKER_UID=1000
RUN useradd -ms /bin/bash --uid 1000 ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
        nux-tools \
        x11-apps

RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        libxtst6 \
        libxv1 \
        libglu1-mesa \
        x11-xserver-utils \
    && wget https://jaist.dl.sourceforge.net/project/virtualgl/2.6.4/virtualgl_2.6.4_amd64.deb \
    && dpkg -i virtualgl_2.6.4_amd64.deb

RUN apt-get install -y --no-install-recommends \
        openssh-server \
        xauth \
    && sed -i "s/^#Port 22/Port 54322/g" /etc/ssh/sshd_config \
    && sed -i "s/^#AllowTcpForwarding yes/AllowTcpForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i "s/^#X11DisplayOffset 10/X11DisplayOffset 10/g" /etc/ssh/sshd_config \
    && sed -i "s/^#X11Forwarding yes/X11Forwarding yes/g" /etc/ssh/sshd_config \
    && sed -i "s/^#X11UseLocalhost yes/X11UseLocalhost no/g" /etc/ssh/sshd_config \
    && echo "XauthLocation /usr/bin/xauth" >> /etc/ssh/sshd_config

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "export LD_LIBRARY_PATH=/usr/local/lib" >> /home/ubuntu/.bashrc

CMD mkdir /run/sshd && /usr/sbin/sshd && tail -f /dev/null
