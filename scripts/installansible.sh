#!/bin/bash

apt update
apt install software-properties-common
add-apt-repository --update ppa:ansible/ansible-2.9
apt install -y ansible
git clone https://gitlab.sxvova.opensource-ukraine.org/root/ansible-roles.git /home/rasavo99/ansible-roles
