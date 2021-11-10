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
    apt-get -y install locate && \
    apt-get -y install unzip && \
    apt-get -y install maven && \
    curl https://dl.google.com/go/go1.17.3.linux-amd64.tar.gz --output go1.17.3.linux-amd64.tar.gz && \
        rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz && \
        rm -rf go1.17.3.linux-amd64.tar.gz
        # export PATH=$PATH:/usr/local/go/bin ALREADY EXPORTED IN MY .bashrc

# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

ENV user alessandroargentieri

# add user
RUN useradd -m -d /home/alessandroargentieri alessandroargentieri && \
    chown -R alessandroargentieri /home/alessandroargentieri && \
    adduser alessandroargentieri sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# switch to user
USER alessandroargentieri
# use user's home directory
WORKDIR /home/alessandroargentieri
# get .bashrc and .gitconfig
COPY ./.bashrc .
COPY ./.gitconfig .
RUN sudo chmod 777 .bashrc && \
    sudo chmod 777 .gitconfig && \
    sed -i 's/\r$//' .bashrc && \
    sed -i 's/\r$//' .gitconfig

# install docker
RUN sudo curl -s https://get.docker.com | bash && \
    sudo usermod -aG docker alessandroargentieri

# install k3d
RUN sudo curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

# install helm 3
RUN sudo curl -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install && \
    rm -rf aws  awscliv2.zip

CMD /bin/bash
