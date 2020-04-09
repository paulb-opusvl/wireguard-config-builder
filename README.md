# Wireguard Configuration Builder

This project build configuration files for the Wireguard VPN.

## Usage

### Server

Create a `.env` file to hold the details required about your network. There is a `.env.sample` file that documents the values of each variable.

Initialise a `wg0.conf` configuration file. This creates an initial server config file by generating a public/private key pair. These are used in the config files for encrypting the traffic.

```shell
$ ./init.sh
```

Once the initialisation is done a configuration file is placed in the `./conf.d` folder. This can be copied to the `/etc/wireguard` folder to be used as:

```shell
$ sudo cp conf.d/wg0.conf /etc/wireguard/
$ sudo wg-quick up wg0
```

### Clients

Client configurations are built using the `client.sh` script. The client configuration fiels are also placed in `./conf.d` and entries relating to the client are also added to the servers `conf.d/wg0.conf` file.

Eg.

```shell
$ ./client.sh 100
```

This will create a client within the servers IP range with the last octet of the specified ID, eg. 100 would create a client 192.168.69.100

You can then give the generated `conf.d/wg0.client.100.conf` file to the intended user and they can import it into their wireguard config.
