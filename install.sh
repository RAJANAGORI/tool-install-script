#!/bin/bash
#Author= Abhinav Saxena
#Contributor= Raja Nagori

bgreen='\033[1;32m'
printf "\n\n${bgreen}***********************************************************************\n"
printf "${bgreen} GoldenEye Installation Script ${reset}\n\n"
echo "Installing required tools"

# #Installing Go language 
echo "Installing GO Language"
wget -c https://golang.org/dl/go1.16.4.linux-amd64.tar.gz -P /tmp/
sudo rm -rf /usr/local/go && sudo -S tar -C /usr/local -xzf /tmp/go1.16.4.linux-amd64.tar.gz

echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.bashrc
source ~/.bashrc

sudo apt-get update && \
sudo apt-get upgrade -y && \
cat tool.list | xargs sudo apt-get install -y 

#Installing metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
chmod 755 msfinstall && \
./msfinstall

#installing go tool
go get -u \
    github.com/tomnomnom/assetfinder \
    github.com/tomnomnom/httprobe \
    github.com/tomnomnom/waybackurls \
    github.com/tomnomnom/anew \
    github.com/tomnomnom/fff \
    github.com/tomnomnom/gf

#creating symlink for the above tools
sudo ln -s ~/go/bin/* /usr/local/bin/