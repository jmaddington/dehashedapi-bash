#/bin/bash

###############################################################################
#
# This runs a search on dehashed.com for given domains.
# Accepts one argument, the name of a file with the domains, one per line
# It will output to ./results/domain.results.json
#
# Example:
# ./run-domains.sh domains.txt
###############################################################################

if [[ ! "$dehashedEnv" ]]
then
    # The ./.env.production file needs to be filled out so the correct environmental variables are set
    # Alternatively, if you have them set somewhere else in the shell this portion will be skipped as long
    # as dehashedEnv is filled out
    source ./.env.production
fi


# Check for jq, which this script uses
jqInstalled=`which jq`
if [[ $jqInstalled == *"not found" ]]
then
    echo "jq not found, exiting before you waste all of your dehashed API credits"
    exit 2
fi

file=$1
sort $file|uniq -u| \
while read -r domain
do

    # What is this ugly regex? Dehashed does not return a valid json, the first line contains
    # "balance":1234
    # where 1234 is the number of credits you have left. 1234 is supposed to have double quotes.
    # This strips it out, it doesn't matter for the results anyway.
    echo "Searching for $domain"
    ./dehashed-api.sh "domain:$domain" | \
    tail -n 1|sed -r 's/("balance":)+[0-9]*,//g' | jq .\
    > ./results/$domain.results.json

    # Make sure we don't get rate limited
    sleep 0.2
done

exit 0