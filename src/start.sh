#!/usr/bin/env bash

##############################################################################
## Prepare ZooKeeper config files(if required)
## Start ZooKeeper server(if required)
##
## Prepare Kafka config files
## Start Kafka server
##############################################################################

# resolve variables
if [[ $ZK_ENABLED = *[!\ ]* ]];
    then
        V_ZK_ENABLED=$ZK_ENABLED
    else
        V_ZK_ENABLED=false
fi

# prepare and start ZooKeeper
if [[ $V_ZK_ENABLED = true ]]; then
    echo '-> Prepare ZooKeeper config files'
    /src/zk-prepare-config.sh

    echo '-> Start ZooKeeper server'
    /src/zk-start.sh
fi


# prepare and start Kafka
echo '-> Prepare Kafka config files'
/src/kafka-prepare-config.sh

echo '-> Start Kafka server '
/src/kafka-start.sh