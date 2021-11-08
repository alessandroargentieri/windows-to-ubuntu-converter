FROM ubuntu

RUN apt-get update && \
      apt-get -y install sudo
RUN apt-get -y install nano
RUN apt-get -y install tree
RUN apt-get -y install git
RUN apt-get -y install jq
RUN apt-get -y install snap
RUN apt-get -y install curl
RUN apt-get -y install wget
RUN apt-get -y install maven
RUN curl https://dl.google.com/go/go1.17.3.linux-amd64.tar.gz --output go1.17.3.linux-amd64.tar.gz \
        rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz \
        rm -rf go1.17.3.linux-amd64.tar.gz
        # export PATH=$PATH:/usr/local/go/bin ALREADY EXPORTED IN MY .bashrc
RUN snap install kubectl --classic        

# TODO install docker
# TODO install k3d


RUN useradd -m alessandroargentieri && echo "alessandroargentieri:alessandroargentieri" | chpasswd && adduser alessandroargentieri sudo

COPY ./.bashrc ./home/alessandroargentieri
COPY ./.gitconfig ./home/alessandroargentieri

USER alessandroargentieri
CMD /bin/bash
