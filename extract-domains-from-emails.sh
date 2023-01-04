#/bin/bash

###############################################################################
#
# This extracts the domain portion from an email address.
# Accepts one argument, the name of a file with the email addresses, one per line
# It will output to <filename>.domains
# This also strips out double quotes, in the event this is a CSV file
#
# Example:
# ./extract-domains-from-emails.sh emails.csv
###############################################################################

file=$1
cat "$file"|sed 's/.*@//g'|sed 's/"//g' > "$file.domains"