#Standing up Mesos-cluster on your Local 

#Prerequisites

Make sure you have the latest VirtualBox correctly installed on your system. If you used Toolbox for Mac to install Docker Machine, VirtualBox is automatically installed.

Use the link for installing latest version of Toolbox
`https://www.docker.com/products/docker-toolbox`

If you have updated to latest version of Toolbox run the following command on your Terminal
`docker-machine upgrade`


#Create a New Machine

```
docker-machine create -d virtualbox --virtualbox-memory 4098 --virtualbox-cpu-count 2 mesos

docker-machine env mesos

eval $(docker-machine env mesos)

```

#Execute the script, This should bring up your Mesos-Cluster.

#`bash mesos-setup.sh`

#Re-run the script always when you change Networks or if cluster is Not reachable



#Use the Example json to deploy couchbase. 

`curl -X POST -H "Content-Type: application/json" http://<yourmarathonip>:8080/v2/apps -d  @cb.json`


#Things to know

Deployments will fail if you give wrong image name in your json,This issue has been reported.





