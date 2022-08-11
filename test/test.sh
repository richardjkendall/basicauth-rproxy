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
    curl -v -u cinosalt:$CINOSALT_PW http://basicauth/
    exit 1
else
    echo "TEST 1: passed"
fi

echo "TEST 2: user without salt, invalid password"
STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" -u cinosalt:blah http://basicauth/)
if test $STATUSCODE -ne 401; then
    echo "TEST 2: failed with status code $STATUSCODE, running again with verbose output"
    curl -v -u cinosalt:blah http://basicauth/
    exit 1
else
    echo "TEST 2: passed"
fi

# test user with salt
echo "TEST 3: user with salt, valid password"
STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" -u ci:$CI_PW http://basicauth/)
if test $STATUSCODE -ne 200; then
    echo "TEST 3: failed with status code $STATUSCODE, running again with verbose output"
    curl -v -u ci:$CI_PW http://basicauth/
    exit 1
else
    echo "TEST 3: passed"
fi

echo "TEST 4: user with salt, invalid password"
STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" -u ci:blah http://basicauth/)
if test $STATUSCODE -ne 401; then
    echo "TEST 4: failed with status code $STATUSCODE, running again with verbose output"
    curl -v -u ci:blah http://basicauth/
    exit 1
else
    echo "TEST 4: passed"
fi

# test invalid user
echo "TEST 5: non existent user"
STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" -u random:random http://basicauth/)
if test $STATUSCODE -ne 401; then
    echo "TEST 5: failed with status code $STATUSCODE, running again with verbose output"
    curl -v -u random:random http://basicauth/
    exit 1
else
    echo "TEST 5: passed"
fi

# test no user
echo "TEST 6: no user"
STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" http://basicauth/)
if test $STATUSCODE -ne 401; then
    echo "TEST 6: failed with status code $STATUSCODE, running again with verbose output"
    curl -v http://basicauth/
    exit 1
else
    echo "TEST 6: passed"
fi