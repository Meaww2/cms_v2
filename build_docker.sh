#!/bin/sh
# @Author: kitt k
# @Date:   2024-05-07 12:42:38
# @Last Modified by:   kitt k
# @Last Modified time: 2024-05-07 13:03:19

app="docker.cms"
docker build -t "${app}" .
docker run -p 8888:8888 -p 8889:8889 -d --name="${app}" -v $PWD:/home/cmsuser/cms "${app}"