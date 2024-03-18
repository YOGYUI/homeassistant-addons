#!/usr/bin/with-contenv bashio
repo_path=/repos/yogyui/HomeNetwork

echo "try to update repository"
git pull

# read `options` from config
CONFIG_MQTT_BROKER="$(bashio::config 'mqtt_broker')"
# CONFIG_RS485="$(bashio::config 'rs485')"
CONFIG_RS485="[$(echo $(bashio::config 'rs485') | sed -e 's/} /},/g')]"  # parse dict list to json list format
CONFIG_DISCOVERY="$(bashio::config 'discovery')"
CONFIG_PARSER_MAPPING="$(bashio::config 'parser_mapping')"

source ${repo_path}/Hillstate-Gwanggyosan/activate.sh
python3 ${repo_path}/Hillstate-Gwanggyosan/app.py \
  --mqtt_broker=$CONFIG_MQTT_BROKER \
  --rs485=$CONFIG_RS485 \
  --discovery=$CONFIG_DISCOVERY \
  --parser_mapping=$CONFIG_PARSER_MAPPING
