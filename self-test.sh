#!/bin/bash

function test {
  RESPONSE=$(curl -so /dev/null -w "%{http_code}\n" ${1})
  if [[ $RESPONSE != 200 ]]; then
    echo "Error ${RESPONSE} on ${1}"
    exit 1
  fi
}
sleep 60 
test $1