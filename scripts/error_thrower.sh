#!/bin/bash
#-----------------------------------------------------------------------------
#
#		error_thrower.sh
#
#		Script that throws error.
#
#		What it does
#			- Logs error
#			- Throws error
#
#		Arguments:
#			1. errorMap -> map of error codes and titles.
#
#-----------------------------------------------------------------------------

#
# SETUP
#
scriptDirectory="$(dirname "$0")"
source "$scriptDirectory/logger.sh" "$1" false

#
# INITIALIZE
#
errorList="$2"
currentErrorCode=0

#
# Building errorMap
# 
declare -A errorMap
for (( i=0; i<${#errorList[@]}; i++ )); do
	errorKey=${errorList[$i]}
	errorCode=$((i + 101))
	errorMap[$errorKey]=$errorCode
done

#-----------------------------------------------------------------------------

#
# Function throw
#
throw() {
	errorKey=$1
	errorDescription="$2"
	errorCode=${errorMap[$errorKey]}

	if [[ "$errorCode" == "" ]]; then
		logError "CRITICAL ERROR" "$errorKey not found in ErrorMap. Please add it."
		exit -99999
	fi

	logError $errorKey "$errorDescription"
	currentErrorCode=$errorCode
}

#
# Function throwAndExit
#
throwAndExit() {
	throw $1 "$2"
	exit $currentErrorCode
}

#-----------------------------------------------------------------------------