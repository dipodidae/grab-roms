#!/bin/bash
provider="https://myrient.erista.me/files/"
destination="/mnt/external-hard-drive/share/roms"

declare -A systems=(
    ["nes"]="No-Intro/Nintendo%20-%20Nintendo%20Entertainment%20System%20%28Headered%29/"
    ["snes"]="No-Intro/Nintendo%20-%20Super%20Nintendo%20Entertainment%20System/"
    ["n64"]="No-Intro/Nintendo%20-%20Nintendo%2064%20%28BigEndian%29/"
    ["gb"]="No-Intro/Nintendo%20-%20Game%20Boy/"
    ["gbc"]="No-Intro/Nintendo%20-%20Game%20Boy%20Color/"
    ["gba"]="No-Intro/Nintendo%20-%20Game%20Boy%20Advance/"
    ["megadrive"]="No-Intro/Sega%20-%20Mega%20Drive%20-%20Genesis/"
    ["ms"]="No-Intro/Sega%20-%20Master%20System%20-%20Mark%20III/"
)

function display_message() {
    message="  $1  "
    len=${#message}
    border=$(printf '%*s' $len | tr ' ' '─')
    
    echo -e "\e[32m┌$border┐"
    echo -e "│$message│"
    echo -e "└$border┘\e[0m"
    echo ""
}

function download_files() {
    system=$1
    
    if [ -f "$destination/$system/.complete" ]; then
        display_message "Files for $system already downloaded. Skipping..."
    else
        display_message "🎮 Downloading files for \e[34m$system\e[32m into \e[34m$destination/$system\e[32m 🚀"
        wget -nv -nc -r -np -nd -A.zip -R "*\(Beta\)*" $provider${systems[$system]} -P "$destination/$system"
        if [ $? -eq 0 ]; then
            touch "$destination/$system/.complete"
        fi
    fi
}

display_message "🚀 Downloading ROMs 🚀"

for system in "${!systems[@]}"; do
    download_files $system
done
