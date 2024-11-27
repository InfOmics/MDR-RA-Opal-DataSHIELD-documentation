#!/bin/bash


#check operating system
if [[ "$OSTYPE" != "linux-gnu" && "$OSTYPE" != "darwin"* ]]; 
then
    echo "The operating system is neither Linux nor Darwin."
    exit 1
fi

#check docker installation
if command -v docker >/dev/null 2>&1;  # This redirects both standard output and standard error to /dev/null
then
    echo "Docker is installed"
    service docker start
else
    echo "Docker not installed on this system. Aborting"
    exit 1
fi

#check docker compose installation
if command -v docker compose >/dev/null 2>&1; 
then
    echo "Docker Compose is installed."
else
    echo "Docker Compose is not installed. Aborting"
    exit 1
fi


#generate certificates
ip=$(cat ./MDR_RA.env | grep -E "^IP_DOMAIN\b" | cut -d"=" -f2)
if [[ ! -d ./certs || -z `ls ./certs` ]]; then
    echo "Missing certificates in certs folder. Please provide one"
    mkdir ./certs >/dev/null 2>&1
    exit 1
fi


#pull
echo "Pulling the latest images..."
docker compose -f docker-compose.yml --env-file MDR_RA.env pull

#up
echo "Starting the server..."
docker compose -f docker-compose.yml --env-file MDR_RA.env up -d


if [ ! -d ./files_to_upload ];
then 
    mkdir ./files_to_upload
fi


echo -e "\nService is up and running at https://$ip"
