#!/bin/bash
#

keychain_location="/path_to/api_credentials.keychain"
keynames=("apiuser") #create additional entries in the list for each key name

get_keychain_username() {
    # $1 is the path to the keychain
    # $2 is the service name (key name)
    security find-generic-password -s $2 -g $1 2>&1 | grep "acct" | cut -d \" -f 4
}

get_keychain_password() {
    # $1 is the path to the keychain
    # $2 is the service name
    security find-generic-password -s $2 -g $1 2>&1 | grep "password" | cut -d \" -f 2
}

get_api_creds() {
    # $1 is the service name
    
    security unlock-keychain -p $API_KEYCHAIN_PASS $keychain_location

    # obtain the username and password from the keychain
    # If obtaining multiple keys, duplicate these two entries to get the user and password for each key
    apiuser=$( get_keychain_username $keychain_location $1 )
    apipwd=$( get_keychain_password $keychain_location $1 )

    apicredentials="${apiuser}:${apipwd}"
    echo $apicredentials
}

unlock_keychain() {
    # unlock the keychain
    if [[ ! $API_KEYCHAIN_PASS ]]; then
        echo "Please run the following command to set the environment variables to unlock the keychain :"
        echo
        echo ". ./set_credentials.sh"
        echo
        exit 1
    fi
}

lock_keychain() {
    # lock the keychain
    security lock-keychain $keychain_location
}

# Main

apicredentials=[]

unlock_keychain
for name in $keynames ; do
    apicredentials[$name]=$( get_api_creds $name )
done
lock_keychain
