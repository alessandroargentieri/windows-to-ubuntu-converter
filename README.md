# windows-to-ubuntu-converter
An interesting way to change your windows into ubuntu

1. First of all clone the project
```bash
git clone https://github.com/alessandroargentieri/windows-to-ubuntu-converter.git
```

2.  Then customize the Dockerfile, the .gitignore and the .bashrc files in the cloned project.

3. Then build the image:
```bash
docker build -t myubuntu .
```

4. From Windows Powershell execute (only the first time):
```bash
docker run -it -d --network host --privileged --name myubuntu -v C:\Users\alessandro.argentier\projects:/home/alessandroargentieri -v //var/run/docker.sock:/var/run/docker.sock myubuntu:latest tail -f /dev/null
```
This will allow to share your project folder with the docker container (mounted on the user's home directory) and to share docker and docker images from inside the container, so you can use docker commands from it.

5. Now, if you use **GitBash** terminal, you can set a **.bashrc** file in your **Windows home directory**.
In this **.bashrc** file (in my case located at C:\Users\alessandro.argentier\.bashrc) append the following lines:
```bash
echo "starting your ubuntu session..."
docker start myubuntu > /dev/null
docker exec -it myubuntu bash -c "cd /home/alessandroargentieri; bash"
```

Here you are! When you open a GitBash terminal from Windows, the docker instance of ubuntu is started and you get automatically connected to your linux user home, which contains your Windows project folder, so you have access to your Windows files and folders from a real Ubuntu system.
