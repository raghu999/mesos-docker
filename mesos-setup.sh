#!/bin/bash

EXTERNAL_IP=`echo $DOCKER_HOST | cut -f2 -d ":" | cut -c3-50`

set -e

check_docker_is_running() {
docker ps ; status=`echo $?`
  if [ $status == 1 ];then
  echo "Please start/restart the docker"
  exit 1
  fi
}

check_version() {
	VER=$(docker-compose version --short)
	if [ $VER "<" 1.7.1 ]; then
  echo "This Version of Docker-compose is Known to have bugs when generating configs Please Update docker-compose"
  exit 1
	fi
}

check_mandatory_flags() {
  if [ -z "$EXTERNAL_IP" ]; then
    echo "external ip not set, use the -e flag." >&2
    usage
    exit 1
  fi
}

create_configuration_files() {
  # compose setup
  sed -e "s|EXTERNAL_IP|${EXTERNAL_IP}|g" docker-compose.yml.template > docker-compose.yml
}

clean_up_existing_containers() {
  docker-compose kill
  docker-compose rm -fv
}

sleep 2

check_docker_is_running
check_version
check_mandatory_flags
create_configuration_files
clean_up_existing_containers
docker-compose up -d


cat <<EOM

###################
#     SUCCESS     #
###################

EOM

echo "Zookeepr is running on ${EXTERNAL_IP}:2181"
printf "\n"
echo "Open http://${EXTERNAL_IP}:5050 for Mesos-Master"
printf "\n"
echo "Open http://${EXTERNAL_IP}:8080 for marathon"
printf "\n"
echo "Mesos-Slave is running on ${EXTERNAL_IP}:5051"
printf "\n"
