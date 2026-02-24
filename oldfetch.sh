#!/bin/bash

# username and hostname
username=$(whoami)
hostname=$(hostname)

# operating system
os=$(uname -s)
distro=""
 
if [ -f /etc/os-release ]; then
  distro=$(source /etc/os-release && echo $PRETTY_NAME)
elif [ -f /etc/lsb-release ]; then
  distro=$(source /etc/lsb-release && echo $DISTRIB_DESCRIPTION)
else
  distro=$(cat /proc/version | awk '{print $1}')
fi

# kernel, uptime, shell, cpu, gpu, and detotated wam
kernel=$(uname -r)
uptime=$(uptime -p)
shell=$(basename "$SHELL")
cpu=$(lscpu | grep "Model name" | cut -d ':' -f2 | tr -d ' ')
gpu=$(lspci | grep -i VGA | cut -d ':' -f3 | tr -d ' ')
ram=$(free -m | grep Mem: | awk '{print $2}')
used_ram=$(free -m | grep Mem: | awk '{print $3}')

# display information
echo "fetch -- $username@$hostname"
echo "os: $distro"
echo "kernel: $kernel"
echo "up: $uptime"
echo "sh: $shell"
echo "cpu: $cpu"
echo "gpu: $gpu"
echo "ram: $used_ram/$rounded_ram MB"
