# Blockchain Explorer for Quorum and Ethereum

![alt text](https://raw.githubusercontent.com/blk-io/epirus-free/master/images/Contracts.png "Epirus Free")

## Introduction

This dockerized environment is designed for viewing private
[Quorum](https://github.com/jpmorganchase/quorum) and [Ethereum](https://github.com/ethereum/go-ethereum) networks.

## Usage

Clone the repo, navigate to the cloned directory and run the instance with:

```bash
./setup.sh {ip} {number_of_node}
docker-compose up
```

Append the `-d` argument to run the containers in the backgroud

You will be able to access the Explorer UI via:

-   http://localhost/

To stop the containers use:

```bash
docker-compose down
```

To connect to new network you should remove the volumes associated with the old network

```bash
docker-compose down -v
``
```
