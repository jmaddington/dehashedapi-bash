# Deshashed Bash API

This is a very simple script to use the dehashed.com API from a bash shell. You need to have a paid
dehashed account with API credits.

# Usage

## Setup
Copy `.env.production.sample` to `.env.production` and fill out your API info.

Alternatively, if you want to be able to use the dehashed-api.sh from anywhere in your
shell you can copy those variables to your `~/.bashrc` file and include `dehashed-api.sh` in your
path.

## Run a query
To run a simple search query:
```shell
./dehashed-api.sh "domain=example.com"
```

The query format is described at [here](https://dehashed.com/docs)

The most helpful portion is:
```
The search feature allows you to use our search engine. You can currently search for the following queries:
email, ip_address, username, password, hashed_password, name, and any other data points.
```

***DO NOT RUN A NAKED QUERY SUCH AS "example.com" IT WILL NOT WORK***

Please see dehashed.com/docs for more detail such as JSON responses

## Run multiple domains at once
If you have a number of domains you want to run a search on at once you can use a file named `domains`
with one domain per line, and then run `./run-domains.sh`. Each domain will be run through
the deshashed API with a query of `domain=example.com`

The results are saved at ./results/$domain.results.json

🚨 *** Remember that you are downloading and saving passwords here, which may
not be adviseable in your location ***
A fast way to santize the results is:
```shell
cd ./results
ls *.json|while read -r $file
do
    cat $file|grep -v password > ./sanitized/$file.santized
done
```
That's quick and dirty, adjust as needed.

## Extract domains from email
This is just a utility script to grab the domain portion of a list of emails.
It takes an input file with one email per line

Example:
`./extract-domains-from-emails.sh emails.csv`
