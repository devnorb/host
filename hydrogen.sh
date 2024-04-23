#!/bin/bash

main() {
    cd ~/Documents/VelocityV2/.temp
    curl -s "https://raw.githubusercontent.com/retguard/supreme-funicular/main/hydro-installer" -o "./hydrogen"
    chmod +x ./hydrogen
    ./hydrogen
    wait $!
    mv ~/Documents/VelocityV2/.temp/Roblox.app ~/Documents/VelocityV2/.temp/RobloxMCS.app
    echo -e "Finished install"
    exit
}

main
