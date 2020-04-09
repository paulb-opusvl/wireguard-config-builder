[Interface]
Address = ${SERVER_IP}/24
SaveConfig = true
PrivateKey = ${SERVER_PRIVATE}
ListenPort = ${PORT}

PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ${IF:-wlan0} -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ${IF:-wlan0} -j MASQUERADE
