#!/bin/bash
#-----------------------------------------------------------------------------
#
#		test.sh
#
#		Script that tests the package.
#
#		What it does:
#			- Runs tests and collects coverage
#
#		Arguments: <none>
#
#-----------------------------------------------------------------------------

#
# SETUP
#
set -e
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
source "$scriptDirectory/logger.sh" $scriptName
errorList=(
	"FLUTTER_TEST_ERROR"
)
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

#
# Running Tests and Collecting Coverage
#
logStep "Running Tests and Collecting Coverage"
echo "Running flutter test --no-pub --coverage"
flutter test --no-pub --coverage
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "FLUTTER_TEST_ERROR" "Error while running flutter test"
fi

#
# END
#
logEnd
exit 0

#-----------------------------------------------------------------------------
