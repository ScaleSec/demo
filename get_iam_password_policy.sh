#!/bin/bash

cli_profiles="prod-acct prod-acct-2"

# Get existing policies, if any
for profile in ${cli_profiles}; do
	echo "\n\n>> Getting CURRENT policy for ${profile}..."
	aws --profile ${profile} iam get-account-password-policy --output=table
done
