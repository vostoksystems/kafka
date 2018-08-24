#!/usr/bin/env bash

##############################################################################
## Prepare Kafka Server config file
##############################################################################

# VARIABLES
CONFIG_FILE_TEMPLATE=/src/config/server-template.properties
CONFIG_FILE=/src/kafka/config/server.properties

#DEFAULT VALUES
DEFAULT_ZK_CONNECT=localhost:2181
DEFAULT_ZK_TIMEOUT=6000


# resolve variables
if [[ ${ZK_CONNECT} = *[!\ ]* ]];
    then
        V_ZK_CONNECT=${ZK_CONNECT}
    else
        V_ZK_CONNECT=${DEFAULT_ZK_CONNECT}
fi

if [[ ${ZK_TIMEOUT} = *[!\ ]* ]];
    then
        V_ZK_TIMEOUT=${ZK_TIMEOUT}
    else
        V_ZK_TIMEOUT=${DEFAULT_ZK_TIMEOUT}
fi

# replace config file
echo '--> Replace config file with new variables'
yes | cp -rf ${CONFIG_FILE_TEMPLATE} ${CONFIG_FILE}

sed -i "s/\${ZK_CONNECT}/$V_ZK_CONNECT/" ${CONFIG_FILE}
sed -i "s/\${ZK_TIMEOUT}/$V_ZK_TIMEOUT/" ${CONFIG_FILE}