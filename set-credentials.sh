#!/bin/bash
#

# . source this script to add API_KEYCHAIN_PASS to the shell environment

# Script to set Keychain password without putting your password into history

echo
echo "Please supply credentials for the keychain of the server(s) you will work on:"

echo
read -s -p "Enter password for the api-credentials keychain : " API_KEYCHAIN_PASS
export API_KEYCHAIN_PASS

echo
echo "   [set_credentials] Credentials exported to environment variable API_KEYCHAIN_PASS."