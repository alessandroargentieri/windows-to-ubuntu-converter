FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install sudo && \
    apt-get -y install nano && \
    apt-get -y install tree && \
    apt-get -y install git && \
    apt-get -y install jq && \
    apt-get -y install snap && \
    apt-get -y install curl && \
    apt-get -y install wget && \
    apt-get -y install maven && \
    curl https://dl.google.com/go/go1.17.3.linux-amd64.tar.gz --output go1.17.3.linux-amd64.tar.gz && \
        rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz && \
        rm -rf go1.17.3.linux-amd64.tar.gz
        # export PATH=$PATH:/usr/local/go/bin ALREADY EXPORTED IN MY .bashrc

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN curl -s https://get.docker.com | bash
RUN curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

RUN useradd -m alessandroargentieri && echo "alessandroargentieri:alessandroargentieri" | chpasswd && adduser alessandroargentieri sudo

RUN chmod 777 ./.bashrc && chmod 777 ./.gitconfig

COPY ./.bashrc ./home/alessandroargentieri
COPY ./.gitconfig ./home/alessandroargentieri

USER alessandroargentieri
CMD /bin/bash
