#!/bin/bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

# run telepresence shell
# telepresence --namespace=todo-app --swap-deployment=todo-app --expose 3000 --run bash

# run debugger
dlv debug --listen=localhost:2345 --headless=true --api-version=2 --log=true ./ -- -config-file="$TELEPRESENCE_ROOT/etc/todo-app/redis.config"

wait
