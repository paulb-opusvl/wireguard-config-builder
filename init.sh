#!/bin/bash

if [ -e '.env' ]; then
  source .env
fi

KEY_PATH=${KEY_PATH:-keys/}

if [ ! -d ${KEY_PATH} ]; then
  mkdir ${KEY_PATH}
fi

if [ ! -e '${KEY_PATH}/server.key' ]; then
  wg genkey | tee ${KEY_PATH}/server.key | wg pubkey > ${KEY_PATH}/server.pub
fi

SERVER_PRIVATE=$(cat ${KEY_PATH}/server.key)
SERVER_PUBLIC=$(cat ${KEY_PATH}/server.pub)

function render_template() {
  eval "echo \"$(cat $1)\""
}

if [ ! -d 'conf.d' ]; then
  mkdir conf.d
fi

render_template wg0.conf.tpl > conf.d/wg0.conf

for f in ${KEY_PATH}/client.*.key
do
  echo $f
  ID=`echo $f | cut -f2 -d'.'`
  ./client.sh ${ID}
done