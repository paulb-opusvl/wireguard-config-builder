[Interface]
Address = ${CLIENT_IP}/32
PrivateKey = ${CLIENT_PRIVATE}
DNS = 1.1.1.1

[Peer]
PublicKey = ${SERVER_PUBLIC}
Endpoint = ${HOST}:${PORT}
AllowedIPs = 0.0.0.0/0