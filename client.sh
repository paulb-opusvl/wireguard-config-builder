#!/bin/bash

if [ -e '.env' ]; then
  source .env
fi

if [ -z $1 ]; then
  echo Must specify a client ID
  exit
fi

CLIENT_IP=$(echo ${SERVER_IP} | cut -f1-3 -d'.').$1

KEY_PATH=${KEY_PATH:-keys}

if [ ! -d ${KEY_PATH} ]; then
  mkdir ${KEY_PATH}
fi

if [ ! -e ${KEY_PATH}/client.${1}.key ]; then
  echo Creating client keys - $KEY_PATH/client.$1.key
  wg genkey | tee ${KEY_PATH}/client.$1.key | wg pubkey > ${KEY_PATH}/client.$1.pub
fi

CLIENT_PRIVATE=$(cat ${KEY_PATH}/client.$1.key)
CLIENT_PUBLIC=$(cat ${KEY_PATH}/client.$1.pub)
SERVER_PUBLIC=$(cat ${KEY_PATH}/server.pub)

function render_template() {
  eval "echo \"$(cat $1)\""
}

if [ ! -d 'conf.d' ]; then
  mkdir conf.d
fi

render_template wg0.client.conf.tpl > conf.d/wg0.client.$1.conf
render_template peer.conf.tpl >> conf.d/wg0.conf
