#!/bin/bash

# ci          user X5yJPjBVWVV7zzR
# cinosalt    user n18q89BODpZ92v3h
CINOSALT_PW="n18q89BODpZ92v3h"
CI_PW="X5yJPjBVWVV7zzR"

# test user without salt
echo "TEST 1: user without salt, valid password"
STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" -u cinosalt:$CINOSALT_PW http://basicauth/)
if test $STATUSCODE -ne 200; then
    echo "TEST 1: failed with status code $STATUSCODE, running again with verbose output"
    curl -v cinosalt:$CINOSALT_PW http://basicauth/
    exit 1
else
    echo "TEST 1: passed"
fi

echo "TEST 2: user without salt, invalid password"
STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" -u cinosalt:blah http://basicauth/)
if test $STATUSCODE -ne 401; then
    echo "TEST 2: failed with status code $STATUSCODE, running again with verbose output"
    curl -v cinosalt:blah http://basicauth/
    exit 1
else
    echo "TEST 2: passed"
fi