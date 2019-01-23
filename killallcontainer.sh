#!/usr/bin/env bash
# stop all container is running
docker stop $(docker ps -aq)

# remove all container
docker rm $(docker ps -aq)

# remove all images
docker rmi $(docker images -aq)

echo "All containers and images are successfully deleted"

# show check container
docker ps -a

# show check images
docker images -a