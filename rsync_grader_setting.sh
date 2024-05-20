#!/usr/bin/env bash
DEFAULT_USER="graderadmin"
DEFAULT_IP="10.4.29.181"
DEFAULT_PORT="22"

if [[ $1 == '-d' ]]; then
    DIRECTION="DOWN"
else
    DIRECTION="UP"
    sftpUser=$1
    sftpHost=$2
    sftpPort=$3
fi

PY_DIR="venv"

SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"/
SCRIPT_DIR_NAME=$(basename $SCRIPTPATH)

[ -z "$sftpUser" ] && sftpUser=$DEFAULT_USER
[ -z "$sftpHost" ] && sftpHost=$DEFAULT_IP
[ -z "$sftpPort" ] && sftpPort=$DEFAULT_PORT

sftpRelativePath=/home/"$sftpUser"/"$SCRIPT_DIR_NAME"/


if [[ $DIRECTION == "UP" ]]; then
    # rsync -avzh --delete --exclude '.git*' --exclude "$SCRIPTNAME" --exclude "$PY_DIR" \
    rsync -avzh --exclude '.git*' --exclude "$SCRIPTNAME" --exclude "$PY_DIR" \
    --exclude 'isolate/*.o' --exclude 'cms/locale/*/LC_MESSAGES/*.mo' \
    --exclude 'cms/.codacy.yaml' --exclude 'cms/.editorconfig' --exclude 'cms/.eslintignore' --exclude 'cms/.travis.yml' \
    --exclude 'cms/server/mo' --exclude 'cms.egg-info' --exclude 'dist/' --exclude 'build/' \
    --exclude 'isolate/isolate/' --exclude 'screenlog*' \
    --exclude '*ip_list*.txt' --exclude '*.json' --exclude '__*__' --exclude 'push_all*.sh' \
    "$SCRIPTPATH" -e "ssh -p $sftpPort"  $sftpUser@$sftpHost:"$sftpRelativePath" # > /dev/null 2>&1
else
    rsync -avzh --exclude '.git*' --exclude "$SCRIPTNAME" --exclude "$PY_DIR" \
    --exclude 'isolate/*.o' --exclude 'cms/locale/*/LC_MESSAGES/*.mo' \
    --exclude 'cms/.codacy.yaml' --exclude 'cms/.editorconfig' --exclude 'cms/.eslintignore' --exclude 'cms/.travis.yml' \
    --exclude 'cms/server/mo' --exclude 'cms.egg-info' --exclude 'dist/' --exclude 'build/' \
    --exclude 'isolate/isolate/' --exclude 'screenlog*' \
    --exclude '*ip_list*.txt' --exclude '*.json' --exclude '__*__' --exclude 'push_all*.sh' \
    -e "ssh -p $sftpPort"  $sftpUser@$sftpHost:"$sftpRelativePath" "$SCRIPTPATH" # > /dev/null 2>&1
fi
