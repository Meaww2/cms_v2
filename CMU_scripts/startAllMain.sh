#!/bin/bash
# export SCREENDIR=$HOME/.screen
# THIS ONE IS FOR ALL OTHER MACHINES except MAIN AND SCOREBOARD
# Add CMS Location to Environment (for crontab)
sudo service postgresql start
# sudo chown -R cmsuser /home/cmsuser/cms

PATH=$PATH:/usr/local/bin
PATH=$PATH:/bin/
PATH=$PATH:/usr/bin

export PATH


# Run CMS
rm /home/$(whoami)/screenlog.*

/usr/bin/screen -S cmsLogService -d -m /bin/bash -c '/usr/local/bin/cmsLogService'
/usr/bin/screen -L -S cmsResourceService -d -m /bin/bash -c '/usr/local/bin/cmsResourceService -a ALL'

# tail -f /dev/null
exec "$@"







