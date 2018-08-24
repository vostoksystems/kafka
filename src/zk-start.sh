#!/usr/bin/env bash

##############################################################################
## Start ZooKeeper server
##############################################################################

rm tmp/zookeeper
/src/kafka/bin/zookeeper-server-start.sh /src/kafka/config/zookeeper.properties