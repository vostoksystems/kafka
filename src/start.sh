#!/usr/bin/env bash

##############################################################################
## Prepare ZooKeeper config files(if required)
## Start ZooKeeper server(if required)
##
## Prepare Kafka config files
## Start Kafka server
##############################################################################

# resolve variables
if [[ ${ZK_EMBEDDED} = *[!\ ]* ]];
    then
        V_ZK_EMBEDDED=${ZK_EMBEDDED}
    else
        V_ZK_EMBEDDED=false
fi

# prepare and start ZooKeeper
if [[ ${V_ZK_EMBEDDED} = true ]]; then
    echo '-> Prepare ZooKeeper config files'
    /src/zk-prepare-config.sh

    echo '-> Start ZooKeeper server'
    nohup /src/zk-start.sh > zk-log.out 2> zk-error.err &
fi

# prepare and start Kafka
echo '-> Prepare Kafka config files'
/src/kafka-prepare-config.sh

echo '-> Start Kafka server '
/src/kafka-start.sh