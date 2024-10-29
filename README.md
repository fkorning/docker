═══════════════════════════════════════════════════════════════════════
# Docker
═══════════════════════════════════════════════════════════════════════

    
<code> 

    #=============================================================================#
    # Manufakture Docker Provisioner
    #-----------------------------------------------------------------------------#

                                  _____        __      __                        
      _____ _____    ____  __ ___/ ____\____  |  | ___/  |_ __ _________   ____  
     /     \\__  \  /    \|  |  \   __\\__  \ |  |/ /\   __\  |  \_  __ \_/ __ \ 
    |  Y Y  \/ __ \|   |  \  |  /|  |   / __ \|    <  |  | |  |  /|  | \/\  ___/ 
    |__|_|  (____  /___|  /____/ |__|  (____  /__|_ \ |__| |____/ |__|    \___  >
          \/     \/     \/                  \/     \/                         \/ 


    #-----------------------------------------------------------------------------#
    # (c) Francis Korning 2024.
    #=============================================================================#
                                                                                   
</code>        
    

Manufakture is a lightweight Cloud and Cluster dev box with a full Windows POSIX environment.

It consists: of Syswin, Cygwin, VirtualBox, Vagrant, Docker (Toolbox), Kubernetes (Minikube).

And then a slew of other Development SDKs and tools (Puppet, Perl, Ruby, Python, Java, etc).

This is the Docker bit.



# Docker provisioner


This is a bit convoluted. We want Docker on a type 2 Hypervisor virtualization VM.

Specifically we want a default Docker Machine provisioned via on a VirtualBox VM.

A while ago, Docker on Windows was done this way via DockerToolBox and KiteMatic.


───────────────────────────────────────────────────────────────────────
# Docker Desktop (Ignore this method)
───────────────────────────────────────────────────────────────────────

Npw the modern way is Docker Desktop, which runs via WSL on a type-1 Hyper-V machine.

Ignore this - For a variety of reasons, we want to this the old way (while it works).

    https://www.docker.com/products/docker-desktop/
    
    https://docs.docker.com/desktop/install/windows-install/


───────────────────────────────────────────────────────────────────────
# Docker Toolbox (The Manufakture Way)
───────────────────────────────────────────────────────────────────────

However we want to run Docker via Cygwin, and a Docker-Machine on VirtualBox.


    https://medium.com/@peorth/using-docker-with-virtualbox-and-windows-10-b351e7a34adc
    
    https://medium.com/@peorth/using-docker-with-virtualbox-and-windows-10-part-ii-1071aaea6949


Docker Toolbox consists of:

    - Boot2Docker.iso - an Alpine linux VirtualBox VM with a docker engine 

    - Docker-Machine - a provisioner to spin it in Vbox as a windows service
     
    - Kite-Matic - a GUI docker container manager, now built-in Docker Desktop 
    
    and docker-clients


All 3 projects are deprecated:

    https://github.com/docker-archive/toolbox
    
    https://github.com/docker/kitematic
    
    https://github.com/docker/machine


The last Docker Toolbox version is 19.03.1 and dates from 2021

It runs fine - there are a few configuration caveats to get it to play well



───────────────────────────────────────────────────────────────────────
## Preqequisites
───────────────────────────────────────────────────────────────────────

* Make sure you have a *Manufacture* SysWin and CygWin full POSIX system running and installed.

	https://sourceforge.net/p/manufacture/syswin/

	https://sourceforge.net/p/manufacture/cygwin/

Manufacture provides the "su.exe" command to run administrator shells (instead of powershell).


* You will of course have installed VirtualBox and Vagrant.

	https://github.com/fkorning/virtualbox
	
	https://github.com/fkorning/vagrant
	
	
* In addition to cygwin, you'll probably have a separate gitbash (installed by DockerToolBox).


───────────────────────────────────────────────────────────────────────
# GitBash
───────────────────────────────────────────────────────────────────────

Docker-Toolbox by default runs on gitbash.  This is fine as its terminal works well.

To get it to work in cygwin we will have to share keys, certs, config files etc.

Install Git for Windows aka GitBash (if not already installed)

    https://gitforwindows.org/


───────────────────────────────────────────────────────────────────────
# Cygwin
───────────────────────────────────────────────────────────────────────

A hangup is the need to install WinPTY as the cygwin terminal shell breaks with docker.

See:

	https://stackoverflow.com/questions/48623005/docker-error-on-windows-the-input-device-is-not-a-tty-if-you-are-using-mintty

    https://github.com/rprichard/winpty

    
Install Winpty (if not already installed by Manufacture-Cygwin):
    
    cd /usr/local/src/
    
    git clone https://github.com/rprichard/winpty.git

    cd winpty
    
    configure
    
    make install
    
    

Proxies:
    
See:

    https://unix.stackexchange.com/questions/263250/running-docker-under-windows-cygwin-environment


═══════════════════════════════════════════════════════════════════════
# Installation
═══════════════════════════════════════════════════════════════════════

    mkdir -p C:/work/Docker/Toolbox

    junction "C:\Program Files\Docker"    "c:\work\Docker"

    cd C:/work/Docker
    
        
───────────────────────────────────────────────────────────────────────
# Docker Toolbox (Deprecated)
───────────────────────────────────────────────────────────────────────

See: 

    https://github.com/docker-archive/toolbox/releases

Download:

    wget https://github.com/docker-archive/toolbox/releases/download/v19.03.1/DockerToolbox-19.03.1.exe


Install in C:/work/Docker/Toolbox


───────────────────────────────────────────────────────────────────────
# Docker Kitematic (Deprecated)
───────────────────────────────────────────────────────────────────────

See:
    
    https://github.com/docker/kitematic/releases
    
Upgrade:

    wget https://github.com/docker/kitematic/releases/download/v0.17.13/Kitematic-0.17.13-Windows.zip


───────────────────────────────────────────────────────────────────────
# Docker Machine (Deprecated)
───────────────────────────────────────────────────────────────────────

See:

    https://github.com/docker/machine/releases
    
Upgrade:

    curl -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-Windows-x86_64.exe > docker-machine.exe
    
    chmod +x docker-machine.exe

    mv docker-machine.exe c:/work/Docker/ToolBox/


───────────────────────────────────────────────────────────────────────
# Configuration
───────────────────────────────────────────────────────────────────────

* Set SYSTEM environment variables

    DOCKER_HOME=c:\work\Docker\Toolbox
    
    PATH=%PATH%;c:\work\Docker\Toolbox


For docker to work everywhere, one must pass the docker-machine environment to every shell.

At minimum, share the .docker folder between the gitbash home and the cygwin home.

* Symlink (or hardlink or junction the following)

    ln -s /users/${USER}/.docker ~/.docker



───────────────────────────────────────────────────────────────────────
# Operation
───────────────────────────────────────────────────────────────────────

* Start VirtualBox


* Create the default VM

    docker-machine create --driver virtualbox default

    
This will create a VirtualBox VM named "default" running docker-machine and boot2docker.

VirtualBox will assign a number of Pseudo-Ethernet network interfaces and an IP address.
 
Typically the assigned IP will be ```192.168.99.100``` with a docker daemon on port 2376.

But this can vary depending on local environment, prior Virtual Box machines, and settings.

    
───────────────────────────────────────────────────────────────────────
# Environment
───────────────────────────────────────────────────────────────────────

For docker to work everywhere, one must pass the docker-machine environment to every shell.

One must Typically set the docker-machine env in Cygwin bashrc, .bashprofile, or .profile


* Edit bash profile and resource scripts


/users/${USER}/.profile 

    # .profile:  .profile for default docker connection
    # install:   place in gitbash/sysgit/msys/minwg64 windows user home
    # configure: then source it from the cygwin .profile or .bash_profile

    # export docker connection parameters  
    echo exporting docker connection parameters
    eval `docker-machine env default | sed -e 's/\\\/\\//g'`
    env | grep -e DOCKER -e COMPOSE | sed -e 's/\\/\//g' | awk '{ print "export " $1; }' > ~/.docker.bash
    
    
~/.profile

    if [ -f "${USERPROFILE}/.docker.bash" ]; then
      . "${USERPROFILE}/.docker.bash"
    fi

~/.docker.bash
    
    export DOCKER_HOME=c:/work/Docker/Toolbox
    export DOCKER_TOOLBOX_HOME=c:/work/Docker/Toolbox
    export COMPOSE_CONVERT_WINDOWS_PATHS=true
    export DOCKER_HOST=tcp://192.168.99.100:2376
    export DOCKER_MACHINE_NAME=default
    export DOCKER_TLS_VERIFY=1
    export DOCKER_TOOLBOX_INSTALL_PATH=C:/work/Docker/Toolbox
    export DOCKER_DESKTOP_HOME=c:/work/Docker/Docker
    export DOCKER_CERT_PATH=C:/Users/Admin/.docker/machine/machines/default
    export DOCKER_TOOLBOX_CERT_PATH=C:/Use


* Share the Docker Environment

    . ~/.docker.bash

    ln -s /users/${USER}/.docker.bash ~/.docker.bash


* Login to Docker

    docker login
    

This should create a config.json hitting the defautl registry


~/.docker/config.json (auth obscured - base64 encoded user:pass)

    {
        "auths": {
                "index.docker.io": {
                        "auth":  "***************************", 
                        "email": "fkorning@gmail.com"
                },
                "registry-1.docker.io": {
                        "auth":  "***************************", 
                        "email": "fkorning@gmail.com"
                }
        },
        "HttpHeaders": {
                "User-Agent": "Docker-Client/19.03.1 (windows)"
        },
        "credsStore": "desktop"
    }


───────────────────────────────────────────────────────────────────────
# Maintenance
───────────────────────────────────────────────────────────────────────

As we are running it on VirtualBox, one must use VBoxManage to take down a Docker-Machine.

By far the easiest way to manage the VMs mnually through the VirtualBox Desktop Manager GUI.

But one main advantages of a VirtualBox / Vagrant / Docker stack is its command-line support.


* List VMs :  (the docker vm is "default")

    $ vboxmanage list vms
    
    "default" {4ac0a965-af82-4524-85c0-adee06c0cb9a}



* Delete a VM : (unregister, destroy, and delete all files)

	$ vboxmanage unregistervm vnname --delete-all


───────────────────────────────────────────────────────────────────────
# Appendix
───────────────────────────────────────────────────────────────────────

Not sure if this is helpful. This is for Docker Desktop, WLS, Hyper-V

    https://learn.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon

    
═══════════════════════════════════════════════════════════════════════
# (c) Francis Korning 2024.
═══════════════════════════════════════════════════════════════════════
