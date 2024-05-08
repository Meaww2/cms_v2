#!/bin/sh
# @Author: kitt k
# @Date:   2024-05-07 12:42:38
# @Last Modified by:   kk
# @Last Modified time: 2024-05-08 17:50:33

app="docker.cms"
docker build -t "${app}" .
docker run --privileged  -p 8888:8888 -p 8889:8889 -p 54321:5432 -p 54322:22 \
-d --name="${app}" -v $PWD:/home/cmsuser/cms "${app}"
# -it --cgroupns=host \
# -v /sys/fs/cgroup:/sys/fs/cgroup "${app}"

