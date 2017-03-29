#Pre-requisites 
docker-engine installed
docer-compose installed

#Provisioning
Clone the below git repository to the machine to be configured:
https://github.com/jcandlin/leodis.git

#Run docker-compose up
docker-compose up -d

#General Issues with current setup
non-standard deployment of apache
root owned deployment of apache
apache should have its owne user i.e www-data
no logging on the vhost or log rotation

#Assumptions
All of the above is deliberate?
the backend estate/farm are all identical servers?

#Outstanding Issues
1. 500 backed errors (e.g. as below)
1. connection refused to the backend - have been reading this maybe due to SElinux, but I believe this is a red-herring since its disabled on the container.
2. Issues with proxypass permissions.
[Tue Mar 28 11:12:30.125717 2017] [proxy:error] [pid 15:tid 140521397745408] (111)Connection refused: AH00957: HTTP: attempt to connect to 127.0.0.1:1337 (localhost) failed
[Tue Mar 28 11:12:30.125806 2017] [proxy:error] [pid 15:tid 140521397745408] AH00959: ap_proxy_connect_backend disabling worker for (localhost) for 60s
[Tue Mar 28 11:12:30.125814 2017] [proxy_http:error] [pid 15:tid 140521397745408] [client 94.4.247.42:55577] AH01114: HTTP: failed to make connection to backend: localhost

root@07929a8c061c:/# curl http://localhost:1337
curl: (7) Failed to connect to localhost port 1337: Connection refused
www.leodis.ac.uk:80 94.4.247.42 - - [28/Mar/2017:11:12:33 +0000] "GET / HTTP/1.1" 503 569 "-"
