#!/bin/bash
provider="https://myrient.erista.me/files/"
destination="./roms"

declare -A systems=(
    ["nes"]="No-Intro/Nintendo%20-%20Nintendo%20Entertainment%20System%20%28Headered%29/"
    ["snes"]="No-Intro/Nintendo%20-%20Super%20Nintendo%20Entertainment%20System/"
    ["n64"]="No-Intro/Nintendo%20-%20Nintendo%2064%20%28BigEndian%29/"
    ["gb"]="No-Intro/Nintendo%20-%20Game%20Boy/"
    ["gbc"]="No-Intro/Nintendo%20-%20Game%20Boy%20Color/"
    ["gba"]="No-Intro/Nintendo%20-%20Game%20Boy%20Advance/"
    ["megadrive"]="No-Intro/Sega%20-%20Mega%20Drive%20-%20Genesis/"
)

echo -e "\e[32m🚀 Downloading ROMs 🚀\e[0m"

for system in "${!systems[@]}"; do
    mkdir -p "$destination/$system"
    echo -e "\e[32m🎮 Downloading files for \e[34m$system\e[32m into \e[34m$destination/$system\e[32m 🚀\e[0m"
    wget -nc -r -np -nd -A.zip -R "*\(Beta\)*" $provider${systems[$system]} -P "$destination/$system"
done
