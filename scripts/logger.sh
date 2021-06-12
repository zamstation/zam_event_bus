#!/bin/bash
#-----------------------------------------------------------------------------
#
#		logger.sh
#
#		Utility to log messages.
#
#		What it does
#			- Logs the beginning of script
#			- Logs Metadata
#			- Logs Step
#			- Logs Checklist
#			- Logs Error
#			- Logs Exit
#			- Logs the end of script
#
#		Arguments:
#			1. scriptName -> Name of the script.
#			2. noInit -> Don't log the beginning of the script.
#
#-----------------------------------------------------------------------------

#
# INITIALIZE
#
scriptName="$1"
noInit=$2
stepCounter=1
ERROR_COLOR="\033[0;31m"
NORMAL_COLOR="\033[0m"

logInit() {
	echo -e "\n---- BEGIN OF SCRIPT $scriptName ----"
}

if [[ ! $noInit ]]; then
	logInit
fi

#-----------------------------------------------------------------------------

#
# Function logMeta
#
logMeta() {
	echo "     $1: $2"
}

#
# Function logStep
#
logStep() {
	stepTitle=$(echo $1 | tr '[:lower:]' '[:upper:]')
	echo -e "\nSTEP $stepCounter: $stepTitle ...\n"
	((stepCounter++))
}

#
# Function logCheck
#
logCheck() {
	echo "[✓] $1"
}

#
# Function logUnCheck
#
logUnCheck() {
	echo "[x] $1"
}

#
# Function logError
#
logError() {
	echo -e "${ERROR_COLOR}\n$1:\n  $2${NORMAL_COLOR}"
}

#
# Function logExit
#
logExit() {
	scriptNameUpper=$(echo $scriptName | tr '[:lower:]' '[:upper:]')
	echo -e "${ERROR_COLOR}\n******** $scriptNameUpper EXITED WITH ERROR CODE: $1 ********${NORMAL_COLOR}"
}

#
# Function logEnd
#
logEnd() {
	echo -e "\n---- END OF SCRIPT $scriptName ----\n"
}

#-----------------------------------------------------------------------------
