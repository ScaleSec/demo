#!/bin/bash

cli_profiles="prod-acct1 prod-acct2"

# loop through multiple accounts
for profile in ${cli_profiles}; do
	reportStatus=
	echo "\n\n>> Creating credential report for ${profile}..."
	until [ "${reportStatus}" == 'COMPLETE' ]; do
		reportStatus=`aws --profile ${profile} --output=json iam generate-credential-report | grep State | awk -F\" '{print $4}'`
		if [ "${reportStatus}" != 'COMPLETE' ]; then
			echo "Waiting on report generation...(${reportStatus})"
			sleep 10
		fi
	done
	echo "\n\n>> Retrieving credential report for ${profile}..."
	aws --profile ${profile} --output=json iam get-credential-report | grep Content | awk -F\" '{print $4}' | base64 -D > iam_credential_report_${profile}.csv
	echo "...report iam_credential_report_${profile}.csv created."
done
