ip=`ipconfig | grep 192.168.1 | sed 's/ /\n/gmi' | grep 192.168.1 | sed 's/\s//gmi'`

cp apps.json apps-local.json
from="https://raw.githubusercontent.com/siatech/nrf-tools/main"
to="http://$ip:8321"
sed -i "s#$from#$to#g" apps-local.json
sed -i "s#$from#$to#g" comhand-configurator
sed -i "s#$from#$to#g" siatech-ble-updater
sed -i 's#"siatech"#"siatech-local"#g' apps-local.json

echo "http://$ip:8321/apps-local.json"

python -m http.server 8321
