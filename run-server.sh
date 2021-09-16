#!/bin/bash

# Copyright (c) 2021 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)

export MQSI_NO_CACHE_SUPPORT=1
export LICENSE=accept
. /opt/ibm/ace-12/server/bin/mqsiprofile

#echo '{"Would normally run IntegrationServer": "true"}'
echo '{}' | IntegrationServer -w /home/aceuser/ace-server --user-script-mode true --stop-after-duration 20000 --admin-rest-api -1 --no-jvm --no-nodejs 2>&1 | grep -v ImbWatchdogTimer
