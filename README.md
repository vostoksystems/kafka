# Kafka

[![Build status](https://travis-ci.org/vostoksystems/kafka.svg?branch=release)](https://travis-ci.org/vostoksystems/kafka)

Docker image for Kafka server with embedded ZooKeeper

- Has bug with container restarting `Error while creating ephemeral at /brokers/ids/0, node already exists` -> https://issues.apache.org/jira/browse/KAFKA-4277. Workaround - restart container.

- - - -

## Kafka server
### Parameters
| Kafka property | Environment property | Default value | Description |
| -------------- | -------------------- | ------------- | ----------- |
| broker.id | BROCKER_ID | 0 | The id of the broker. This must be set to a unique integer for each broker. |
| num.network.threads  | NUM_NETWORK_THREADS | 3 | The number of threads that the server uses for receiving requests from the network and sending responses to the network |
| num.io.threads | NUM_IO_THREADS | 8 | The number of threads that the server uses for processing requests, which may include disk I/O |
| socket.send.buffer.bytes | SOCKET_SEND_BUFFER_BYTES | 102400 | The send buffer (SO_SNDBUF) used by the socket server |
| socket.receive.buffer.bytes | SOCKET_RECEIVE_BUFFER_BYTES | 102400 | The receive buffer (SO_RCVBUF) used by the socket server |
| socket.request.max.bytes | SOCKET_REQUEST_MAX_BYTES | 104857600 | The maximum size of a request that the socket server will accept (protection against OOM) |
| num.partitions | NUM_PARTITIONS | 1 | The default number of log partitions per topic. More partitions allow greater parallelism for consumption, but this will also result in more files across the brokers. |
| num.recovery.threads.per.data.dir | NUM_RECOVERY_THREADS_PER_DATA_DIR | 1 | The number of threads per data directory to be used for log recovery at startup and flushing at shutdown. This value is recommended to be increased for installations with data dirs located in RAID array. |
| zookeeper.connect | ZK_CONNECT | localhost:2181 | Zookeeper connection string (see zookeeper docs for details). This is a comma separated host:port pairs, each corresponding to a zk server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002". You can also append an optional chroot string to the urls to specify the root directory for all kafka znodes. |
| zookeeper.connection.timeout.ms | ZK_TIMEOUT | 6000 | Timeout in ms for connecting to zookeeper |


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