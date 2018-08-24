#!/usr/bin/env bash

##############################################################################
## Prepare Kafka Server config file
##############################################################################

# VARIABLES
CONFIG_FILE_TEMPLATE=/src/config/server-template.properties
CONFIG_FILE=/src/kafka/config/server.properties


# FUNCTIONS
function replace() {
    if [[ $2 = *[!\ ]* ]];
        then
            V_VAR=$2
        else
            V_VAR=$3
    fi
    sed -i "s/\${$1}/$V_VAR/" ${CONFIG_FILE}
}


# replace config file
echo '--> Replace config file'
yes | cp -rf ${CONFIG_FILE_TEMPLATE} ${CONFIG_FILE}


# placeholder representation | env variable | default value
replace BROCKER_ID ${BROCKER_ID} 0

replace NUM_NETWORK_THREADS ${NUM_NETWORK_THREADS} 3
replace NUM_IO_THREADS ${NUM_IO_THREADS} 8

replace SOCKET_SEND_BUFFER_BYTES ${SOCKET_SEND_BUFFER_BYTES} 102400
replace SOCKET_RECEIVE_BUFFER_BYTES ${SOCKET_RECEIVE_BUFFER_BYTES} 102400
replace SOCKET_REQUEST_MAX_BYTES ${SOCKET_REQUEST_MAX_BYTES} 104857600

replace NUM_PARTITIONS ${NUM_PARTITIONS} 1

replace NUM_RECOVERY_THREADS_PER_DATA_DIR ${NUM_RECOVERY_THREADS_PER_DATA_DIR} 1

replace ZK_CONNECT ${ZK_CONNECT} localhost:2181
replace ZK_TIMEOUT ${ZK_TIMEOUT} 6000
