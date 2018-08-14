#!/bin/bash
#

# . source me

# Script to set Keychain password without putting your password into history

echo
echo "Please supply credentials for the keychain of the server(s) you will work on:"

echo
read -s -p "Enter password for jamf-api keychain : " JAMF_API_PASS
export JAMF_API_PASS

echo
echo "   [set_credentials] Credentials exported to environment variable JAMF_API_PASS."