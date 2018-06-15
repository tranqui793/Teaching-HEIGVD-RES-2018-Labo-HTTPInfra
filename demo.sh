#!/bin/bash
# Script to automatize the lab HTTP Demo

echo "Killing old containers ..."
docker kill $(docker ps -q) 2>/dev/null 
docker rm $(docker ps -a -q) 2>/dev/null

echo -e "\nRunning server containers ...."

	docker run -d -it --name static1 res/apache_php
	staticIP1=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' static1)

	docker run -d -it --name static2 res/apache_php
        staticIP2=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' static2)

	docker run -d -it --name static3 res/apache_php
        staticIP3=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' static3)

	docker run -d -it --name dynamic1 res/express_dynamic
	dynamicIP1=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dynamic1)


	docker run -d -it --name dynamic2 res/express_dynamic
        dynamicIP2=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dynamic2)

        docker run -d -it --name dynamic3 res/express_dynamic
        dynamicIP3=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dynamic3)


echo -e "\nStatics server running on $staticIP1 $staticIP2 $staticIP2 \nDynamics server running on $dynamicIP1 $dynamicIP2 $dynamicIP3"

echo -e "\nReverse proxy running ..."
docker run -d -p 8080:80 -e STATIC_APP1=$staticIP1 -e DYNAMIC_APP1=$dynamicIP1:3000 \
			 -e STATIC_APP2=$staticIP1 -e DYNAMIC_APP2=$dynamicIP2:3000 \
			 -e STATIC_APP3=$staticIP1 -e DYNAMIC_APP3=$dynamicIP3:3000 \
 --name apache_rp res/apache_rp

echo -e "\nRunning portainer managment UI ..."
docker volume rm portainer_data > /dev/null 2>&1
docker volume create portainer_data
docker run -d --name portainer -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

portainerIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' portainer)

echo -e "\nPortainer managment UI running on $portainerIP:9000"

