#!/bin/bash
#

keychain_location="/path_to/jamf-api.keychain"

get_keychain_username() {
    # $1 is the path to the keychain
    # $2 is the service name
    security find-generic-password -s $2 -g $1 2>&1 | grep "acct" | cut -d \" -f 4
}

get_keychain_password() {
    # $1 is the path to the keychain
    # $2 is the service name
    security find-generic-password -s $2 -g $1 2>&1 | grep "password" | cut -d \" -f 2
}

get_api_creds() {
    # unlock the keychain
    if [[ ! $JAMF_API_PASS ]]; then
        echo "Please run the following command to set the environment variables to unlock the keychain :"
        echo
        echo ". ./set_credentials.sh"
        echo
        exit 1
    fi
    security unlock-keychain -p $JAMF_API_PASS $keychain_location

    apiuser=$( get_keychain_username $keychain_location apiuser )
    apipwd=$( get_keychain_password $keychain_location apiuser )

    jssCredentials="${apiuser}:${apipwd}"
    echo "${jssCredentials}"

    # lock the keychain
    security lock-keychain $keychain_location
}

get_api_creds
