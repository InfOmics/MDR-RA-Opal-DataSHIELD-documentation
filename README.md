<p align="center">
    <img src="docs/imgs/mdr-ra.png" alt="mdr-ra.png" width=400 />
</p>

# Opal-DataSHIELD ecosystem deployment and usage for the MDR-RA project

## Synopsis
The purpose of this document is to describe the deployment process, configuration, initiation, and usage of the Opal-DataSHIELD ecosystem required by the MDR-RA project. To ensure portability and reproducibility the deployment employs [Docker](https://www.docker.com/). Docker supports container-based deployment enhancing the ecosystem's portability.

## Deploying the Opal-DataSHIELD ecosystem

### Basic Requirements
- Ubuntu >= 22.04.3 LTS (Jammy Jellyfish)
- Docker >= 27.1.1
- Ubuntu Terminal

### Docker engine's deployment
The deployment of the Opal-DataSHIELD ecosystem requires the Docker Engine to be installed in the machine hosting the ecosystem. Details abount the Docker Engine's installation can be found at [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/).

Before installing the Docker Engine, any conflicting packages must be uninstalled. To uninstall any conflicting packages, run the following command:
```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```
**NOTE-1:** `apt-get` might report that none of these packages is installed.<br>
**NOTE-2:** older images, containers, volumes, and networks are stored in `/var/lib/docker/`. They are not automatically removed when uninstalling Docker. To start with a fresh installation, cleaning up any existing data, refer to [https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine](https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine).

Before installing the Docker Engine on a host machine, it is required to set up the Docker repository. Afterward, Docker can be installed and updated from the repository.

To set up Docker's `apt` repository, run the following commands:
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

To install the Docker packages, run the following command:
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

To test if Docker's installation was succesful, run the `hello-world` image:
```
sudo docker run hello-world
```
This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.