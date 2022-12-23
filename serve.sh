#!/bin/sh

ip=$(ipconfig | grep "Adresse IPv4" | sed 's/ /\n/gmi' | grep "192\\.168\\.1\\." | sed 's/\s//gmi' | head -n1)
port=8321
localUrl="http://$ip:$port"
remoteUrl="https://github.com/siatech/nrf-tools/raw/main"

# this function is called when Ctrl-C is sent
function trap_ctrlc ()
{
    # perform cleanup here
    echo "Ctrl-C caught...performing clean up"
 
    rm apps-local.json
    from=$localUrl
    to=$remoteUrl
    sed -i "s#$from#$to#g" comhand-configurator
    sed -i "s#$from#$to#g" siatech-ble-updater


    echo "Cleanup done."
 
    # exit shell script with error code 2
    # if omitted, shell script will continue execution
    exit 2
}
 
# initialise trap to call trap_ctrlc function
# when signal 2 (SIGINT) is received
trap "trap_ctrlc" 2

cp apps.json apps-local.json
from=$remoteUrl
to=$localUrl
sed -i "s#$from#$to#g" apps-local.json
sed -i "s#$from#$to#g" comhand-configurator
sed -i "s#$from#$to#g" siatech-ble-updater
sed -i 's#"siatech"#"siatech-local"#g' apps-local.json

echo "Add this URL to your nrf-connect sources: $localUrl/apps-local.json"

python -m http.server $port --bind $ip
