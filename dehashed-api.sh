#/bin/bash

###############################################################################
#
# This file takes a query formated for dehashed and runs it. It outputs to stdout
# It takes exactly one argument, the query you want to run.
#
###############################################################################

if [[ ! "$dehashedEnv" ]]
then
    # The ./.env.production file needs to be filled out so the correct environmental variables are set
    # Alternatively, if you have them set somewhere else in the shell this portion will be skipped as long
    # as dehashedEnv is filled out
    source ./.env.production
fi

query=$1

echo "[INFO] Query: $query"

curl "https://api.dehashed.com/search?query=$query" \
-u "$apiUser:$apiKey" \
-H 'Accept: application/json' \
-s --no-progress-meter

# Dehashed's API limit is 5 calls/second, this is an easy way to make sure you don't hit it.
sleep 0.2