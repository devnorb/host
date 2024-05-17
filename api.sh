#!/bin/bash

main() {
    cd ~/Documents/VelocityV2/.dependencies
    curl "https://raw.githubusercontent.com/devnorb/host/main/MacSploitAPI" -o "./MacSploitAPI"
    chmod +x MacSploitAPI
    echo -e "Finished install"
    exit
}

main
