#!/bin/bash

# Copyright (C) 2016 wikiwi.io
#
# This software may be modified and distributed under the terms
# of the MIT license. See the LICENSE file for details.

PID_FILE=/var/run/google-fluentd/google-fluentd.pid

set -eo pipefail

stopDaemon() {
  service google-fluentd stop
  kill -9 ${LOG_PID}
}

service google-fluentd start
trap stopDaemon SIGINT SIGTERM
touch /var/log/google-fluentd/google-fluentd.log
tail /var/log/google-fluentd/google-fluentd.log -f &
LOG_PID=$!

# echo Waiting for collectd daemon to start
while [ ! -f "${PID_FILE}" ] ; do
  sleep 1;
done

# Waiting for collectd daemon to stop
while [ -f "${PID_FILE}" ] ; do
  sleep 1;
done

