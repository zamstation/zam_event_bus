#!/bin/bash
#-----------------------------------------------------------------------------
#
#		analyze.sh
#
#		Script that analyzes the package.
#
#		What it does:
#			- Gets dependencies
#			- Formats Code
#			- Runs dart analyze
#
#		Arguments: <none>
#
#-----------------------------------------------------------------------------

# SETUP
set -e
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
source "$scriptDirectory/logger.sh" $scriptName
errorList=(
	"DART_PUB_GET_ERROR"
	"DART_FORMAT_ERROR"
	"DART_ANALYZE_ERROR"
)
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

#
# Getting Dependencies
#
logStep "Getting Dependencies"
echo "Running dart pub get"
dart pub get
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "DART_PUB_GET_ERROR" "Error while running dart pub get"
fi

#
# Formatting Code
#
logStep "Formatting Code"
echo "Running dart format ."
dart format .
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "DART_FORMAT_ERROR" "Error while running dart format"
fi

#
# Analyzing Code
#
logStep "Analyzing Code"
echo "Running dart analyze --fatal-infos --fatal-warnings ."
dart analyze --fatal-infos --fatal-warnings .
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "DART_ANALYZE_ERROR" "Error while running dart analyze"
fi

#
# END
#
logEnd
exit 0

#-----------------------------------------------------------------------------
