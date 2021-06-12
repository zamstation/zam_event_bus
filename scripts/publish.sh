#!/bin/bash
#-----------------------------------------------------------------------------
#
#		publish.sh
#
#		Script that publishes the package to pub.dev
#
#		What it does
#			- Runs validate.sh
#			- Runs analyze.sh
#			- Runs test.sh
#			- Publishes package pub.dev
#
#		Arguments:
#			1. env -> Environment - should be prod or test
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
	"DART_PUB_PUBLISH_ERROR"
)
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

#
# INITIALIZE
#
env='test'
if [[ $1 == 'prod' ]]; then
	env='prod'
fi
logMeta "Environment" $env
logMeta "Pointer" "left"
logMeta "Read only" "false"

#
# Running script validate.sh
#
sh $scriptDirectory/validate.sh

#
# Running script analyze.sh
#
sh $scriptDirectory/analyze.sh

#
# Running script test.sh
#
sh $scriptDirectory/test.sh

# Publishing package
logStep "Publishing Package"
if [[ $env == 'test' ]]; then
	echo "Running dart pub publish --dry-run"
	dart pub publish --dry-run
else
	echo 'Running dart pub publish'
	dart pub publish
fi
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "DART_PUB_PUBLISH_ERROR" "Error while running dart pub publish"
fi

#
# END
#
logEnd
exit 0

#-----------------------------------------------------------------------------
