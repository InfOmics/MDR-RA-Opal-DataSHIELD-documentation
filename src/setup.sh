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
    docker --version
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


#check IP domain 
if [ "$ip" != "yourDomain" ];
then
    echo "ip or domain set correctly."
else
    echo "Error: ip or domain not correctly set. Check .env file. Aborting"
    exit 1
fi


#pull
echo "Pulling the latest images..."
output=$(docker compose -f docker-compose.yml --env-file MDR_RA.env pull 2>&1)

if [ $? -ne 0 ]; then
    echo "Error: Failed to pull the latest images."
    echo "Details: $output"
    exit 1
else
    echo "Success: Pulled the latest images."
    #echo "$output"
fi
echo "**************************************"

# Up
echo "Starting the server..."

echo "Starting Docker Compose services..."
output=$(docker compose -f docker-compose.yml --env-file MDR_RA.env up -d 2>&1)

if [ $? -ne 0 ]; then
    echo "Error: Failed to start services."
    echo "Details: $output"
    exit 1
else
    echo "Success: Services started successfully."
    echo "$output"
fi

if [ ! -d ./files_to_upload ];
then 
    mkdir ./files_to_upload
fi


echo -e "\nService is up and running at https://$ip"
