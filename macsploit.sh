#!/bin/bash

main() {
    cd ~/Documents/VelocityV2/.temp
    curl -s "https://git.abyssdigital.xyz/main/jq-macos-amd64" -o "./jq"
    chmod +x ./jq
    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    local version=$(curl -s "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer" | ./jq -r ".clientVersionUpload")
    curl "http://setup.rbxcdn.com/mac/$version-RobloxPlayer.zip" -o "./RobloxPlayer.zip"
    rm ./jq

    [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"
    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip

    curl "https://git.abyssdigital.xyz/main/macsploit.zip" -o "./MacSploit.zip"

    unzip -o -q "./MacSploit.zip"
    curl -Os "https://git.abyssdigital.xyz/main/macsploit.dylib"
    mv ./macsploit.dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib"
    ./insert_dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
    mv "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"
    rm -r "/Applications/Roblox.app/Contents/MacOS/RobloxPlayerInstaller.app"
    rm ./insert_dylib
    rm -rf MacSploit.app MacSploit.zip __MACOSX hwid RobloxMCS.app
    mv /Applications/Roblox.app ~/Documents/VelocityV2/.temp
    mv ~/Documents/VelocityV2/.temp/Roblox.app ~/Documents/VelocityV2/.temp/RobloxMCS.app
    echo -e "Finished install"
    exit
}

main
