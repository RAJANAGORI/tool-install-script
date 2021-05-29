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
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/go1.16.4.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin:~/go/bin >> ~/.zshrc

sudo apt-get update && \
sudo apt-get upgrade -y && \
cat tool.list | xargs sudo apt-get install -y 

#installing go tool
cat script.list | xargs go get -u 

#Installing Nuclei
GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
nuclei -update-templates

#installing pip2 module and frida-tool
cd /tmp/
wget -L https://bootstrap.pypa.io/pip/2.7/get-pip.py -O get-pip.py
python /tmp/get-pip.py
python -m pip install --upgrade pip setuptools wheel
python -m pip install frida-tools
sudo pip3 install frida-tools
export PATH="/home/kali/.local/bin:$PATH"

#creating symlink for the above tools
sudo ln -s ~/go/bin/* /usr/local/bin/
