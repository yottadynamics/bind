# bind

### Note: I'm using podman and it should be working with docker as well. 

## Make usage 

```
$ make help 
build                          Build container from Dockerfile
run                            Run $(PROJECT_NAME) container
restart                        Restart container
test                           Run nslookup on foobar.yotta.local
clean                          Remove previous build
help                           Display this help screen

```

## Build the image

```
$  make build 
STEP 1: FROM centos:8
STEP 2: RUN yum -y install bind-utils bind &&     yum clean all
--> Using cache a3fd30d59d9b4935e1ef18a6a998b79eae2dc448051684d04fe15462aa8a3c04
STEP 3: ADD ./entrypoint.sh / 
--> Using cache 0a4faeafde797774b80e79b99771e9c4cddd2e6906ed5c481371f2b4731b9ca7
STEP 4: VOLUME /opt/named
--> Using cache 5fa7d1787a74795892b8dacbc8ddb4e2b58edfe11d1852ccc629e4af4ff2a6eb
STEP 5: EXPOSE 53 53/udp
--> Using cache 3d92cce07b31a7c2950f78ddd04fc836610c77cde75fc462f80613db3a9a8913
STEP 6: RUN named-checkconf /etc/named.conf
--> Using cache c586ef054118c855c2bfd9b3fc60b305e627015dacaabd3ad8f52008da979499
STEP 7: ENTRYPOINT [ "/entrypoint.sh" ]
--> Using cache 91cf97dc3bbaf4bf910e5f6e8a3058f8b50df64f32c86a796a6e3fdde4d23450
STEP 8: COMMIT yottad-bind
91cf97dc3bbaf4bf910e5f6e8a3058f8b50df64f32c86a796a6e3fdde4d23450
```

## Run the container 

```
$ make run
42ca264ebb665af3392cd550985e5bb21311892cdcea43140f224f00c3ff6c01
```
## Test using nslookup on test record

```
make test 
Server:		yotta-lab.yotta.local
Address:	192.168.100.150#53

Name:	foo.yotta.local
Address: 10.1.1.10
```

## Check your running container 

```
$ podman ps 
CONTAINER ID  IMAGE                  COMMAND  CREATED             STATUS                 PORTS                                   NAMES
42ca264ebb66  localhost/bind:latest           About a minute ago  Up About a minute ago  0.0.0.0:53->53/tcp, 0.0.0.0:53->53/udp  yottad-bind
```

## Add DNS testrecord (foobar.yotta.local) to conf/yotta.local.db

## Restart your contaienr and test 

```
$ make restart 
42ca264ebb665af3392cd550985e5bb21311892cdcea43140f224f00c3ff6c01

$ nslookup foobar.yotta.local $(uname -n)
Server:		yotta-lab.yotta.local
Address:	192.168.100.150#53

Name:	foobar.yotta.local
Address: 10.1.1.15

```
