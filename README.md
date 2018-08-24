# Kafka

[![Build status](https://travis-ci.org/vostoksystems/kafka.svg?branch=release)](https://travis-ci.org/vostoksystems/kafka)

Docker image for Kafka server with embedded ZooKeeper

- Has bug with container restarting `Error while creating ephemeral at /brokers/ids/0, node already exists` -> https://issues.apache.org/jira/browse/KAFKA-4277. Workaround - restart container.

- - - -

## Kafka server
### Parameters
| Kafka property | Environment property | Default value |
| -------------- | -------------------- | ------------- |
| zookeeper.connect | ZK_CONNECT | localhost:2181 |
| zookeeper.connection.timeout.ms | ZK_TIMEOUT | 6000 |


- - - - 

## Embedded ZooKeeper(Deprecated)
### Enable
Turn on ZooKeeper, using ZK_ENABLED=true environment variable
```bash
    -e ZK_EMBEDDED=true
```

### Parameters
TBD

### Logs
ZooKeeper logs and error logs can be found in files `zk-log.out` and `zk-error.err` in root directory
```bash
    docker exec -it kafka-container-name sh
    cat zk-error.err
    cat zk-log.out
```

- - - -

## Usage
Start ZooKeeper server and Kafka server
```bash
    docker network create --subnet 172.30.0.0/16 kafka-net
    
    docker run --name zoo --net kafka-net --ip 172.30.0.23 -p 2181:2181 zookeeper:3.4.13
    docker run --name kafka --net kafka-net --ip 172.30.0.24 -p 9092:9092 -e ZK_CONNECT=172.30.0.23:2181 vostoksystems/kafka
```

Start ZooKeeper server and Kafka server using docker-compose
```yaml
version: '3.1'

services:
  zoo:
      image: zookeeper
      hostname: zoo
      ports:
        - 2181:2181

  kafka:
      image: vostoksystems/kafka
      ports:
        - 9092:9092
      environment:
        ZK_CONNECT: zoo:2181
      restart: always    
```

Start Kafka server with embedded ZooKeeper
```bash
    docker run --name kafka -p 2181:2181 -p 9092:9092 -e ZK_EMBEDDED=true vostoksystems/kafka
```

Build Kafka image
```bash
    docker build -t vostoksystems/kafka .
```