#!/bin/bash

do_check() {
  # check hostname is not empty
  if [ "${TARGET_HOST}x" == "x" ]; then
    echo "TARGET_HOST is not set; use '-e TARGET_HOST=host:port'"
    exit 0
  fi

  if [ "${LOCUST_FILE}x" == "x" ]; then
  	 mv examples/basic.py locustfile.py
  	echo "Default Locust file: locustfile.py from  examples/basic.py"
  else
    curl -O $LOCUST_FILE -o "locustfile.py"
    echo "Locust file: locustfile.py from\n$LOCUST_FILE"
  fi
}

LOCUST_CMD="/usr/local/bin/locust"
LOCUST_OPTS="-f locustfile.py --host=$TARGET_URL"
LOCUST_MODE=${LOCUST_MODE:-standalone}

if [ "$LOCUST_MODE" = "master" ]; then
  LOCUST_OPTS="$LOCUST_OPTS --master"
elif [ "$LOCUST_MODE" = "slave" ]; then
  LOCUST_OPTS="$LOCUST_OPTS --slave --master-host=$MASTER_HOST"
elif [ "$LOCUST_MODE" = "consumer-single" ]; then
  LOCUST_OPTS="$LOCUST_OPTS --consumer --consumer-host=$CONSUMER_HOST --clients=$CLIENTS --hatch-rate=1 --num-request=$REQUESTS --no-web --only-summary"
fi

do_check

echo "=> Starting locust"
echo "$LOCUST_CMD $LOCUST_OPTS"
$LOCUST_CMD $LOCUST_OPTS
echo "done"
