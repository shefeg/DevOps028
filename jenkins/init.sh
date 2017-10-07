#!/usr/bin/env bash

function os_type { #checks which installation commands to use depending on debian/centos distributive
    which yum && { echo centos; return; }
    which apt-get && { echo debian; return; }
}

echo
echo "---Checking configuration of Python environment:---"
sleep 2

function py_checker { #checks if python 2.7.* is installed, if not - tries to install it 2 times
    for i in `seq 2`;
        do
            if [[ $(python -V 2>&1) != *"Python 2.7"* ]];
                then
                    echo
                    echo "Python is not installed"
                    sleep 2
                    echo "Installing Python:"
                    echo
                    sleep 2
                    if [[ $(os_type) == *"debian"* ]]; then
                        sudo apt-get install python -y
                    else
                        yum install python -y
                    fi
                else
                    echo
                    echo "Python is installed"
                    echo
                    sleep 2
                    break
             fi
        done
}

py_checker

echo
echo "---Installing build pre-requisites for Ansible:---"
sleep 2
if [[ $(os_type) == *"debian"* ]];
    then
        sudo apt-get install build-essential libssl-dev libffi-dev python-dev -y
    else
        yum install build-essential libssl-dev libffi-dev python-dev -y
fi

function pip_checker { #checks if pip 1.* is installed, if not - tries to install it 2 times
    for i in `seq 2`;
        do
            if [[ $(pip --version 2>&1) != *"/usr/local/lib/python"* ]];
                then
                    echo
                    echo "Pip is not installed"
                    echo
                    sleep 2
                    echo "Installing Pip:"
                    echo
                    sleep 2
                    if [[ $(os_type) == *"debian"* ]]; then
                        cd /tmp
                        sudo wget https://bootstrap.pypa.io/get-pip.py
                        sudo python ./get-pip.py
                    else
                        yum install python-pip -y
                    fi
                 else
                    echo
                    echo "Pip is installed"
                    echo
                    sleep 2
                    break
             fi
        done
}

pip_checker

echo
echo "---Installing Ansible:---"
sleep 2
function ansible_checker { #checks if Ansible is installed, if not - tries to install it 1 time
    for i in `seq 2`;
        do
            if [[ $(ansible --version 2>&1) != *"dist-packages/ansible"* ]];
                then
                    echo
                    echo "Ansible is not installed"
                    echo
                    sleep 2
                    echo "Installing Ansible and needed packages:"
                    echo
                    sleep 2
                    sudo pip install ansible
                    sudo mkdir /etc/ansible
                    sudo cp /home/vagrant/demo1/provision/hosts /etc/ansible/hosts
                    sudo pip install boto
                    sudo pip install boto3
                else
                    echo
                    echo "Ansible and needed packages installed"
                    echo
                    cat private_key > /home/vagrant/.ssh/id_rsa
                    chmod 600 /home/vagrant/.ssh/id_rsa
                    sleep 2
                    break
             fi
        done
}

ansible_checker

echo
echo "---Running Ansible script:---"
sleep 2
cd $WORKSPACE/provision
ansible-playbook main.yml