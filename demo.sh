#!/bin/bash
# Script to automatize the lab HTTP Demo

echo "Killing old containers ..."
docker kill $(docker ps -q) 2>/dev/null 
docker rm $(docker ps -a -q) 2>/dev/null

echo -e "\nRunning $1 server containers including the 2 principals..."
docker run -d -it --name apache_php res/apache_php 
docker run -d -it --name express_locations res/express_dynamic 

for i in `seq 2 $1`
do
	docker run -d -it res/apache_php
	docker run -d -it res/express_dynamic
done

staticIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' apache_php)
dynamicIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' express_locations)

echo -e "\nPrincipal static server running on $staticIP \nPrincipal dynamic server running on $dynamicIP"

echo -e "\nReverse proxy running ..."
docker run -d -p 8080:80 -e STATIC_APP=$staticIP -e DYNAMIC_APP=$dynamicIP:3000 --name apache_rp res/apache_rp

echo -e "\nRunning portainer managment UI ..."
docker volume rm portainer_data > /dev/null 2>&1
docker volume create portainer_data
docker run -d --name portainer -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

portainerIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' portainer)

echo -e "\nPortainer managment UI running on $portainerIP:9000"
