#!/bin/bash

echo get docker container id
docker ps -a

echo terminal into the docker container
docker exec -it b855c869a707 /bin/bash
