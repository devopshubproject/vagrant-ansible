#!/bin/bash

### Install ansible ###

echo "Running script to install Ansible on Server Node"

### Updating DNF repo cache ###

sudo dnf makecache -y

### Install epel-relase package ###

sudo dnf install epel-release -y 
sudo dnf makecache -y 

### To install ansible ###

echo "Ansible Install"
sudo dnf install ansible -y 

echo "Checking the version of ansible"
ansible --version | grep

echo "Installation is done"
