# AWS-EC2-Ubuntu-Desktop
Aws vnc ubuntu desktop setup

This is a script to create a vnc connection to an aws machine and install a ubuntu desktop onto the machine that can be accessed through a vnc viewer. This script need to be wget to be used, I suggest putting it on dropbox then copying link from there to use wget. Then chmod 777 the file and mv it to aws-vnc-ubuntudesktop.sh

It creates a new user called awsgui.
Asks for a new unix password allowing access to awsgui user.
Then creates a new vncserver password, that is needed to connect to the vnc server. 
Also downloads ubuntu-desktop and vnc4server.
Then edits a startup file ~/.vnc/xstartup and inserts the correct text for the ubuntu desktop.
Uses a gnome windows manager in this xstartup file.

script is a file in this repository

After installation aws-vnc-ubuntudesktop.sh can be deleted to save space. 
