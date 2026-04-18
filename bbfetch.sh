#!/bin/sh

# Colors
reset="\033[0m"
bold="\033[1m"
white="\033[1m\033[37m"
blue="\033[34m"
cyan="\033[36m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
magenta="\033[35m"

# Get System Info (OpenWrt compatible)
user=$(id -un)
hostname=$(cat /proc/sys/kernel/hostname)
os=$(grep "DISTRIB_DESCRIPTION" /etc/openwrt_release | cut -d"'" -f2)
[ -z "$os" ] && os="OpenWrt"
kernel=$(uname -r)
uptime=$(uptime | awk -F, '{sub(".*up ", "", $1); print $1}' | sed 's/^ *//')
shell=$SHELL
[ -z "$shell" ] && shell="ash"

# CPU Info (Handles BusyBox grep)
cpu=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //')
[ -z "$cpu" ] && cpu=$(grep "system type" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //')

# Memory Info (in MiB)
mem_total=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)
mem_free=$(awk '/MemFree/ {print int($2/1024)}' /proc/meminfo)
mem_used=$((mem_total - mem_free))

# Display Fetch
cat << EOF
${white}    .--.      ${cyan}${bold}${user}${reset}@${cyan}${bold}${hostname}${reset}
${white}   |o_o |     ${white}---------------------${reset}
${white}   |:_/ |     ${blue}${bold}OS:${reset} $os
${white}  //   \ \    ${blue}${bold}Kernel:${reset} $kernel
${white} (|     | )   ${blue}${bold}Uptime:${reset} $uptime
${white} /'\_   _/\`\\  ${blue}${bold}Shell:${reset} $shell
${white} \___)=(___/  ${blue}${bold}CPU:${reset} $cpu
              ${blue}${bold}Memory:${reset} ${mem_used} MiB / ${mem_total} MiB
              ${red}██ ${green}██ ${yellow}██ ${blue}██ ${magenta}██ ${cyan}██ ${white}██${reset}
EOF
