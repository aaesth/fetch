#!/bin/bash

# colors
C_RED=$'\e[31m'
C_GREEN=$'\e[32m'
C_YELLOW=$'\e[33m'
C_BLUE=$'\e[34m'
C_MAGENTA=$'\e[35m'
C_CYAN=$'\e[36m'
C_WHITE=$'\e[37m'
C_BOLD=$'\e[1m'
C_RESET=$'\e[0m'

# info
USER=$(whoami)
HOST=$(hostname)
if [ -f /etc/os-release ]; then
    OS=$(grep -P '^PRETTY_NAME=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
else
    OS=$(uname -s)
fi
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //')
SHELL_NAME=$(basename "$SHELL")

# cpu
if command -v lscpu &> /dev/null; then
    CPU=$(lscpu | grep 'Model name' | awk -F: '{print $2}' | sed -E 's/^[ \t]+//')
else
    CPU=$(grep 'model name' /proc/cpuinfo | head -1 | awk -F: '{print $2}' | sed -E 's/^[ \t]+//')
fi

# memory
if command -v free &> /dev/null; then
    MEM=$(free -m | awk 'NR==2{printf "%s MiB / %s MiB", $3, $2}')
else
    MEM="Unknown"
fi

# spaces
USER_HOST="${USER}@${HOST}"
DASHES=$(printf "%${#USER_HOST}s" "" | tr ' ' '-')

# output
cat << EOF
${C_BOLD}${C_WHITE}    .--.      ${C_CYAN}${USER}${C_RESET}@${C_CYAN}${HOST}${C_RESET}
${C_BOLD}${C_WHITE}   |o_o |     ${C_WHITE}${DASHES}${C_RESET}
${C_BOLD}${C_WHITE}   |:_/ |     ${C_BLUE}${C_BOLD}OS:${C_RESET} ${OS}
${C_BOLD}${C_WHITE}  //   \\ \\    ${C_BLUE}${C_BOLD}Kernel:${C_RESET} ${KERNEL}
${C_BOLD}${C_WHITE} (|     | )   ${C_BLUE}${C_BOLD}Uptime:${C_RESET} ${UPTIME}
${C_BOLD}${C_WHITE} /'\\_   _/\\\`\\ ${C_BLUE}${C_BOLD}Shell:${C_RESET} ${SHELL_NAME}
${C_BOLD}${C_WHITE} \\___)=(___/  ${C_BLUE}${C_BOLD}CPU:${C_RESET} ${CPU}
              ${C_BLUE}${C_BOLD}Memory:${C_RESET} ${MEM}
EOF
echo "              ${C_RED}██ ${C_GREEN}██ ${C_YELLOW}██ ${C_BLUE}██ ${C_MAGENTA}██ ${C_CYAN}██ ${C_WHITE}██${C_RESET}"
