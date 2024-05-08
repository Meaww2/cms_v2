#!/bin/bash
screen -S cmsAdminWebServer -X quit
screen -S cmsResourceService -X quit
screen -s cmsRankingWebServer -X quit
screen -S cmsLogService -X quit
screen -S cmsProxyService -X quit

screen -wipe

