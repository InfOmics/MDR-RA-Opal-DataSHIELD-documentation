<p align="center">
    <img src="docs/imgs/mdr-ra.png" alt="mdr-ra.png" width=400 />
</p>

# Opal-DataSHIELD ecosystem deployment and usage for the MDR-RA project

## Synopsis
The purpose of this document is to describe the deployment process, configuration, 
initiation, and usage of the OBiBa Opal-DataSHIELD ecosystem required by the MDR-RA 
project. To ensure portability and reproducibility the deployment employs [Docker](https://www.docker.com/). 
Docker supports container-based deployment enhancing the ecosystem's portability.

## Table of contents 

1 [System deployment](#system-deployment)
<br>&nbsp; 1.1 [Prerequisites](#prerequisets)
<br>&nbsp;&nbsp; 1.1.1 [Operating System Requirements](#operating-system-requirements)
<br>&nbsp;&nbsp; 1.1.2 [Docker engine deployment](#112-docker-engine-deployment)

### 1 System Deployment

This section provides a comprehensive guide for deploying the OBiBa Opal-DataSHIELD 
ecosystem on a **Linux** environment. The deployment process will be discussed in 
detail, including prerequisites such as the required operating system (OS) and recommended 
version, as well as the installation of necessary external dependencies. For a smooth setup, 
[Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) 
are essential components, enabling efficient container management and orchestration for 
DataSHIELD services. In the sections below, we will cover each prerequisite and guide you 
through the installation and configuration steps needed to prepare your environment for 
deploying the Opal-DataSHIELD ecosystem.

#### 1.1 Prerequisets

Before proceeding with the deployment of the OBiBa Opal-DataSHIELD ecosystem, ensure 
that your system meets the following prerequisites. Below, we describe each prerequisite 
and provide guidance on how to install them or troubleshoot any missing components:

- Ubuntu >= 22.04.3 LTS (Jammy Jellyfish)
- Ubuntu Terminal
- Docker >= 27.1.1
- Docker-compose
- make

##### 1.1.1 Operating System Requirements

To ensure optimal performance and compatibility, the OBiBa Opal-DataSHIELD ecosystem 
requires **Ubuntu 22.04.3 LTS (Jammy Jellyfish)** or a later version to operate correctly. 
This specific version of Ubuntu is recommended due to its long-term support and stability 
(LTS), providing a robust foundation for deploying the necessary services. Additionally, 
it is crucial to have access to an Ubuntu terminal, as this will be the primary interface 
for executing commands throughout the deployment process.

For users who need to obtain Ubuntu 22.04.3 LTS, the operating system can be downloaded 
from the official [Ubuntu website](https://ubuntu.com/download). Follow the instructions 
to create a bootable USB drive or DVD, or consider installing it in a virtual machine if 
you prefer to run it alongside your existing operating system.

Once Ubuntu is installed, you can access the terminal by searching for "Terminal" 
in the applications menu or by using the keyboard shortcut **Ctrl + Alt + T**. The terminal
will be the primary tool for executing the commands required for the deployment of the OBiBa 
Opal-DataSHIELD ecosystem.

##### 1.1.2 Docker engine deployment

[Docker](https://www.docker.com/) is an open-source platform that enables developers 
to automate the deployment, scaling, and management of applications within lightweight, 
portable containers. Containers package an application and its dependencies, ensuring 
consistent performance across various environments, whether on local machines, virtual 
machines, or cloud infrastructure. By leveraging Docker, users can streamline development 
workflows, enhance collaboration, and maintain system integrity while deploying complex 
applications like the OBiBa Opal-DataSHIELD ecosystem. Its robust ecosystem also includes 
tools like [Docker Compose](https://docs.docker.com/compose/), which simplifies the 
management of multi-container applications through a user-friendly configuration format.

Docker Compose is a powerful tool designed to simplify the management of multi-container 
Docker applications. It allows users to define and run multiple containers as a single 
application using a simple [YAML](https://yaml.org/) configuration file, known as 
`docker-compose.yml`. This file specifies the services, networks, and volumes required 
for the application, along with their respective configurations and dependencies.

With Docker Compose, users can easily start, stop, and manage all containers with 
a single command, streamlining the development and deployment process. It also facilitates 
environment consistency, making it easier to replicate complex setups across different 
stages of development, testing, and production. This makes Docker Compose particularly 
useful for applications that require multiple interconnected services, such as databases, 
web servers, and application servers, enabling a seamless orchestration of the entire 
application stack.

Below is a description of the steps required to install Docker and Docker Compose on 
the machine designated for deploying the OBiBa Opal-DataSHIELD ecosystem. These instructions 
will guide you through the installation process, ensuring that your environment is correctly 
set up for optimal performance and functionality.

###### Installing Docker and Docker Compose

The deployment of the Opal-DataSHIELD ecosystem requires the installation of the Docker 
Engine on the host machine. For detailed instructions on installing the Docker Engine, 
you can refer to the official documentation at [Docker Engine Installation]((https://docs.docker.com/engine/install/)).

**NOTE-1**: The following steps assume that the user has **`sudo`** privileges to execute the 
necessary commands for the installation process.

Before installing Docker, it is essential to remove any conflicting packages that 
might interfere with the installation. To uninstall any potential conflicts, run the 
following command:
```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

**NOTE-2**: The `apt-get` command may report that none of these packages are installed.

**NOTE-3**: Older images, containers, volumes, and networks are stored in 
`/var/lib/docker/` and are not automatically removed when uninstalling Docker. To 
start with a clean installation, consider cleaning up existing data by following 
the guidelines provided here.

Before proceeding with the installation of Docker Engine, you must set up the Docker 
repository. This allows you to install and update Docker directly from the repository.

To set up Docker's apt repository, execute the following commands:
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Once the repository is set up, you can install the Docker packages using the following command:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

To verify that Docker has been installed successfully, you can run the hello-world image 
with the following command:
```
sudo docker run hello-world
```

This command downloads a test image and executes it in a container. Upon running, 
the container will print a confirmation message indicating that the installation was 
successful, and then it will exit.

After successfully installing Docker, it is important to add your user to the Docker 
group. This allows the user to run Docker commands without needing to prefix them with 
`sudo`, enhancing convenience and streamlining workflow.

Use the following command to add your user to the Docker group, replacing `<username>` 
with your actual username:
```
sudo usermod -aG docker <username>
```

After executing the command, you need to log out and log back in for the changes to take 
effect. Alternatively, you can also restart your terminal session.

To verify that the user has been added to the Docker group, you can run:
```
groups <username>
```

This command will list the groups associated with your user account, and you should 
see "docker" included in the output.

By adding your user to the Docker group, you can now run Docker commands directly 
without needing elevated privileges, simplifying your interactions with the Docker 
ecosystem.

To verify that Docker Compose is installed and available on your system, run the 
following command:
```
docker-compose --version
```

This command will display the installed version of Docker Compose if it is correctly 
installed. Seeing the version number confirms that Docker Compose is available and 
ready for use. If you receive an error or no version information, you may need to check 
your installation steps.