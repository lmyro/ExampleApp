
#!/usr/bin/env bash
# check if there is an instance runnig with image name we are deploying
CURRENT_INSTANCE=$(docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")

# if instance exist, stop instance
if [ "$CURRENT_INSTANCE" ]
then
  docker rm $(docker stop $CURRENT_INSTANCE)
fi

# pull down the instance from dockerhub
docker pull $IMAGE_NAME

# check if a docker container exists with name of node_app and if so, remove container
CONTAINER_EXISTS=$(docker ps -a | grep node_app)
if [ "$CONTAINER_EXISTS" ]
then 
  docker rm node_app
fi

# create container called node_app on port 8443 from docker image
docker create -p 8443:8443 --name node_app $IMAGE_NAME

# write private key to file
echo $PRIVATE_KEY > privatekey.pem

# write server key to file
echo $SERVER > server.crt

# add private key to node_app docker container
docker cp ./privatekey.pem node_app:/privatekey.pem

# add server key to node_app docker container
docker cp ./server.crt node_app:/server.crt

# start the node_app container
docker start node_app