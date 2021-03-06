#!/bin/bash 

# dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E &&
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -cs) main" &&
# apt-fast
sudo add-apt-repository ppa:apt-fast/stable &&
# android
sudo add-apt-repository ppa:nilarimogard/webupd8 &&
sudo add-apt-repository ppa:upubuntu-com/sdk &&
# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &&
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &&

sudo apt-get update &&
sudo apt-get install -y apt-fast &&

# remove
sudo apt-fast remove -y rhythmbox tomboy gwibber thunderbird evolution nautilus-sendto ubuntuone-client empathy firefox unity-webapps-* &&
sudo apt-fast autoremove -y &&

# codecs
sudo apt-fast install -y ubuntu-restricted-extras flashplugin-installer mencoder &&

# internet
sudo apt-fast install -y dropbox google-chrome-stable network-manager-vpnc &&

# fs
sudo apt-fast install -y ssh samba gparted dropbox &&

# system
sudo apt-fast install -y synaptic rar p7zip-full gnome-system-tools unity-tweak-tool libappindicator1 eyed3 &&
 
# media
sudo apt-fast install -y mp3gain flickrbackup && 

# dev
sudo apt-fast install -y gedit curl git virtualbox android-tools-adb android-tools-fastboot

# aliases
touch .bash_aliases &&
rm .bash_aliases &&
echo "alias install='sudo apt-fast install'" >> .bash_aliases &&
echo "alias remove='sudo apt-fast remove'" >> .bash_aliases &&
echo "alias update='sudo apt-fast update'" >> .bash_aliases &&
echo "alias ..='cd ..'" >> .bash_aliases &&
echo "alias ...='cd ../../'" >> .bash_aliases &&
echo "alias shutdown='sudo shutdown –h now'" >> .bash_aliases && 
echo "alias restart='sudo shutdown –r now'" >> .bash_aliases &&
echo "alias g='git'" >> .bash_aliases &&
echo "alias gpush='git push'" >> .bash_aliases &&
echo "alias gs='git status'" >> .bash_aliases &&
echo "alias gpp='git pull --rebase && git push'" >> .bash_aliases &&
echo "alias gspps='git stash && git pull --rebase && git push && git stash pop'" >> .bash_aliases &&

# virtualbox
VBoxManage setextradata global GUI/Customizations noMenuBar,noStatusBar &&
sudo usermod -aG vboxusers $USER &&

# vcs details
EMAIL="example@example.com" &&
NAME="Your Name" &&

# git
git config --global user.email "$EMAIL" &&
git config --global user.name "$NAME" &&
git config --global alias.c commit &&
git config --global alias.s status &&
git config --global alias.a add &&
git config --global alias.d diff &&
git config --global push.default simple &&

# hg
touch .hgrc &&
rm .hgrc &&
echo "[ui]" >> .hgrc &&
echo "username = $NAME <$EMAIL>" >> .hgrc &&

# ruby
\curl -sSL https://get.rvm.io | bash -s stable --ruby &&
source ~/.rvm/scripts/rvm &&

# samba
sudo cp $HOME/Install/Settings/smb.conf /etc/samba/smb.conf &&
sudo chmod 664 /etc/samba/smb.conf &&
sudo restart smbd &&
sudo smbpasswd -L -a $USER &&
sudo smbpasswd -L -e $USER &&

# swap
if [ -n "grep 'sysctl -w vm.swappiness' /etc/rc.local" ]; then
	sudo sed -i 's/exit 0/sysctl -w vm.swappiness=0\nexit 0/g' /etc/rc.local
fi &&

# bash
if [ -n "grep --quiet 'source ~/.rvm/scripts/rvm' ~/.bashrc" ]; then
	echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc &&
fi &&

# hosts
if [ -n "grep '10.0.0.1 router' /etc/hosts" ]; then
	echo -e "10.0.0.1 router" | sudo tee -a /etc/hosts
fi &&
if [ -n "grep '10.0.0.2 xbmc' /etc/hosts" ]; then
	echo -e "10.0.0.2 xbmc"   | sudo tee -a /etc/hosts;
fi

