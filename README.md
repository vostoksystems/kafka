# Kafka

[![Build status](https://travis-ci.org/vostoksystems/kafka.svg?branch=release)](https://travis-ci.org/vostoksystems/kafka)

Docker image for Kafka server with embedded ZooKeeper
- - - -

## Kafka server
### Parameters
TBD

- - - - 

## Embedded ZooKeeper
### Enable
Turn on ZooKeeper, using ZK_ENABLED=true environment variable
```
    -e ZK_ENABLED=true
```

### Parameters
TBD

### Logs
ZooKeeper logs and error logs can be found in files `zk-log.out` and `zk-error.err` in root directory
```
    docker exec -it kafka-container-name sh
    # cat zk-error.err
    # cat zk-log.out
```

- - - -

## Useful commands
```
    docker build -t vostoksystems/kafka .
```

```
    docker run --name kafka -p 9092:9092 -e ZK_ENABLED=true vostoksystems/kafka
```