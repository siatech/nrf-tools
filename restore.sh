ip=`ipconfig | grep 192.168.1 | sed 's/ /\n/gmi' | grep 192.168.1 | sed 's/\s//gmi'`

rm apps-local.json
from="http://$ip:8321"
to="https://raw.githubusercontent.com/siatech/nrf-tools/main"
sed -i "s#$from#$to#g" comhand-configurator
sed -i "s#$from#$to#g" siatech-ble-updater