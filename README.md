# windows-to-ubuntu-converter
An interesting way to change your windows into ubuntu

Create a Dockerfile in a folder and insert a .bashrc for linux
Dockerfile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FROM ubuntu

RUN apt-get update && \
      apt-get -y install sudo
RUN apt-get -y install nano
RUN apt-get -y install tree
RUN apt-get -y install git
RUN apt-get -y install jq
RUN apt-get -y install snap

RUN useradd -m alessandroargentieri && echo "alessandroargentieri:alessandroargentieri" | chpasswd && adduser alessandroargentieri sudo

COPY ./.bashrc ./home/alessandroargentieri

USER alessandroargentieri
CMD /bin/bash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
docker build -t myubuntu .
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From Windows Powershell execute only the first time :
docker run -it -d --network host --name myubuntu -v C:\Users\alessandro.argentier\projects:/home/alessandroargentieri myubuntu:latest tail -f /dev/null

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In C:\Users\alessandro.argentier if you have a .bashrc for your GitBash, append:

echo "starting your ubuntu session..."
docker start myubuntu > /dev/null
docker exec -it myubuntu bash -c "cd /home/alessandroargentieri; bash"

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Here you are! When you open a GitBash terminal, the docker instance of ubuntu is started and you get automatically connected to your user home, which contains your Windows projecr folder.



