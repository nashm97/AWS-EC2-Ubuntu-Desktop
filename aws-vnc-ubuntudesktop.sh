#!/bin/bash

sudo useradd -m awsgui
sudo passwd awsgui
sudo usermod -aG admin awsgui

echo enter new vnc password:

read password

while [ ${#password} -le 6 ]
do
   echo password needs to be 6 or more characters:
   echo enter new vnc password:
   read password
done
cat <<EOT>> tmpxx
#!/usr/bin/expect
spawn /usr/bin/vncpasswd
expect "Password:"
send $password\r
expect "Verify:"
send $password\r
expect eof
exit
EOT

sudo apt-get -y install expect
sudo mv tmpxx ~awsgui
sudo chmod 777 ~awsgui/tmpxx
sudo chown awsgui ~awsgui/tmpxx

sudo -H -u awsgui bash << EOF
cd ~awsgui
sudo sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart
sudo apt-get -y update
sudo apt-get -y install ubuntu-desktop
sudo apt-get -y install vnc4server
pwd
whoami
./tmpxx
vncserver
sudo chmod 777 ~/.vnc
sudo apt-get -y install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
echo "#!/bin/sh"> ~/.vnc/xstartup
echo >> ~/.vnc/xstartup
echo export XKL_XMODMAP_DISABLE=1>> ~/.vnc/xstartup
echo unset SESSION_MANAGER >> ~/.vnc/xstartup
echo unset DBUS_SESSION_BUS_ADDRESS>> ~/.vnc/xstartup
echo >> ~/.vnc/xstartup
echo "[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup">> ~/.vnc/xstartup
echo "[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources">> ~/.vnc/xstartup
echo xsetroot -solid grey>> ~/.vnc/xstartup
echo "vncconfig -iconic &">> ~/.vnc/xstartup
echo >> ~/.vnc/xstartup
echo "gnome-panel &">> ~/.vnc/xstartup
echo "gnome-settings-daemon &">> ~/.vnc/xstartup
echo "metacity &">> ~/.vnc/xstartup
echo "nautilus &">> ~/.vnc/xstartup
echo "gnome-terminal &">> ~/.vnc/xstartup
EOF
#sudo chown -R awsgui:awsgui ~awsgui/.viminfo
sudo chown -R awsgui:awsgui ~awsgui/.cache