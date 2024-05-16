#!/bin/bash

main() {
    cd ~/Documents/VelocityV2/temp
    curl -s "https://raw.githubusercontent.com/retguard/supreme-funicular/main/hydro-installer" -o "./hydrogen"
    chmod +x ./hydrogen
    ./hydrogen
    wait $!
    # mv /Applications/Roblox.app ~/Documents/VelocityV2/temp
    # mv ~/Documents/VelocityV2/temp/Roblox.app ~/Documents/VelocityV2/temp/RobloxHYR.app
    cd ..
    cd .dependencies
    curl "https://raw.githubusercontent.com/devnorb/host/main/MacSploitAPI" -o "./MacSploitAPI"
    chmod +x MacSploitAPI
    echo -e "Finished install"
    exit
}

main
