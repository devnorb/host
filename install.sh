#!/bin/bash

main() {
    clear
    echo -e "Welcome to the MacSploit Experience!"
    echo -e "Install Script Version 2.6"

    echo -ne "Checking License..."
    curl -s "https://git.raptor.fun/main/jq-macos-amd64" -o "./jq"
    chmod +x ./jq
    
    curl -s "https://git.raptor.fun/sellix/hwid" -o "./hwid"
    chmod +x ./hwid
    
    local user_hwid=$(./hwid)
    local hwid_info=$(curl -s "https://git.raptor.fun/api/whitelist?hwid=$user_hwid")
    local hwid_resp=$(echo $hwid_info | ./jq -r ".success")
    rm ./hwid
    
    if [ "$hwid_resp" != "true" ]
    then
        echo -ne "\rEnter License Key:       \b\b\b\b\b\b"
        read input_key

        echo -n "Contacting Secure Api... "
        
        local resp=$(curl -s "https://git.raptor.fun/api/sellix?key=$input_key&hwid=$user_hwid")
        echo -e "Done.\n$resp"
        
        if [ "$resp" != 'Key Activation Complete!' ]
        then
            rm ./jq
            exit
            return
        fi
    else
        local free_trial=$(echo $hwid_info | ./jq -r ".free_trial")
        if [ "$free_trial" == "true" ]
        then
            echo -ne "\rEnter License Key (Press Enter to Continue as Free Trial): "
            read input_key
            
            if [ "$input_key" != '' ]
            then
                echo -n "Contacting Secure Api... "
                
                local resp=$(curl -s "https://git.raptor.fun/api/sellix?key=$input_key&hwid=$user_hwid")
                echo -e "Done.\n$resp"
            fi
        else
            echo -e " Done.\nWhitelist Status Verified."
        fi
    fi

    echo -e "Downloading Latest Roblox..."
    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    local versionInfo=$(curl -s "https://git.raptor.fun/main/version.json")
    
    curl "https://setup.rbxcdn.com/mac/version-0e4f9b5c84614d79-RobloxPlayer.zip" -o "./RobloxPlayer.zip"
    # apparently roblox just reuploaded the old version 💀
    rm ./jq
    echo -n "Installing Latest Roblox... "
    [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"
    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip
    echo -e "Done."

    echo -e "Downloading MacSploit..."
    curl "https://git.raptor.fun/main/macsploit.zip" -o "./MacSploit.zip"

    echo -n "Installing MacSploit... "
    unzip -o -q "./MacSploit.zip"
    echo -e "Done."

    echo -n "Updating Dylib..."
    if [ "$version" != "$robloxVersion" ] && [ "$mChannel" == "preview" ]
    then
        curl -Os "https://git.raptor.fun/preview/macsploit.dylib"
    else
        curl -Os "https://git.raptor.fun/main/macsploit.dylib"
    fi
    
    echo -e " Done."
    echo -e "Patching Roblox..."
    mv ./macsploit.dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib"
    mv ./libdiscord-rpc.dylib "/Applications/Roblox.app/Contents/MacOS/libdiscord-rpc.dylib"
    ./insert_dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
    mv "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"
    rm -r "/Applications/Roblox.app/Contents/MacOS/RobloxPlayerInstaller.app"
    rm ./insert_dylib

    echo -n "Installing MacSploit App... "
    [ -d "/Applications/MacSploit.app" ] && rm -rf "/Applications/MacSploit.app"
    mv ./MacSploit.app /Applications/MacSploit.app
    rm ./MacSploit.zip
    
    touch ~/Downloads/ms-version.json
    echo $versionInfo > ~/Downloads/ms-version.json
    
    echo -e "Done."
    echo -e "Install Complete! Developed by Nexus42!"
    exit
}

main
