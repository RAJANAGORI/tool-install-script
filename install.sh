#!/bin/bash
#Script-Designer : Raja Nagori

bgreen='\033[1;32m'
printf "\n\n${bgreen}***********************************************************************\n"
printf "${bgreen} GoldenEye Installation Script ${reset}\n\n"

#update and upgrade
echo "Update and Upgrade the required dependecies for security updates"
apt-get update &&\
apt-get upgrade -y

sleep 5s

echo "Installing required tools"

#install snap 
apt-get install snapd &&\
    systemctl enable --now snapd apparmor

#checking for git version
git_version=$(git --version)
if [ $git_version ]; then
    echo "Git is install" + $git_version
else
    echo "not installed? I'm going to fire the command in 5 second"
    sleep 5s
    apt-get install -y git
fi

#Checking python version
echo "checking for the python version"
ver=$(python3 -c"import sys; print(sys.version_info.major)")
if [ $ver -eq 3 ]; then
    echo "python version is 3"
    sleep 5s
    cat tool.list | xargs sudo apt-get install -y
    #installing dirsearch 
    git clone https://github.com/maurosoria/dirsearch.git ~/home/${USER} &&\
    pip3 install -r ~/home/${USER}/dirsearch/requirements.txt
else 
    echo "Unknown python version: $ver"
    exit 1
fi

#checking for go version
go_version=$(go version)
if [$go_version]; then
    echo "GO is install with the version" + $go_version
    
    #installing go tool
    cat script.list | xargs go get -u 
    
    #Installing Nuclei
    GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
    nuclei -update-templates
else
    echo "not installed? I'm going to fire the command in 5 second"
    sleep 5s
    snap install --classic --channel=1.15/stable go
 
    #installing go tool
    cat script.list | xargs go get -u 
    
    #Installing Nuclei
    GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
    nuclei -update-templates
fi

#install findomain
cat emumeration-script | xargs wget -P /tmp &&\
chmod +x /tmp/findomain-linux &&\
mv /tmp/findomain-linux /usr/bin/

#creating symlink for the above tools
ln -s ~/go/bin/* /usr/local/bin/
