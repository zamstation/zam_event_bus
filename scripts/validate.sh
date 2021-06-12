#!/bin/bash
#-----------------------------------------------------------------------------
#
#		validate.sh
#
#		Script that validates the package.
#
#		What it does:
#			- Checks if all the required files exist
#			- Formats Code
#			- Runs dart analyze
#
#		Arguments: <none>
#
#		Errors:
#			101: PUBSPEC_NOT_FOUND_ERROR
#			102: DIRECTORY_NOT_FOUND_ERROR
#			103: FILE_NOT_FOUND_ERROR
#			104: PUBSPEC_VALIDATION_ERROR
#
#-----------------------------------------------------------------------------

# SETUP
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
source "$scriptDirectory/logger.sh" $scriptName
errorList=(
	"PUBSPEC_NOT_FOUND_ERROR"
	"DIRECTORY_NOT_FOUND_ERROR"
	"FILE_NOT_FOUND_ERROR"
	"PUBSPEC_VALIDATION_ERROR"
)
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

#
# Extracting package name from pubspec
#
logStep "Extracting package name from pubspec"

if [[ ! -f "pubspec.yaml" ]]; then
	throwAndExit "PUBSPEC_NOT_FOUND_ERROR" "pubspec.yaml file is not found in the root directory."
fi

packageName=$(grep "name:" "pubspec.yaml" | cut -d ":" -f2 | xargs)
logMeta "Package Name" "$packageName"

#
# Checking required directories
#
logStep "Checking required directories"

directories=(
	".github"
	".github/ISSUE_TEMPLATE"
	".github/workflows"
	"example"
	"example/lib"
	"lib"
	"lib/src"
	"scripts"
	"test"
)

for directory in ${directories[@]}; do
	if [[ -d $directory ]]; then
		logCheck "$directory"
	else
		logUnCheck "$directory"
		throwAndExit "DIRECTORY_NOT_FOUND_ERROR" "$directory does not exist."
	fi
done

#
# Checking required files
#
logStep "Checking required files"

files=(
	"README.md"
	"CHANGELOG.md"
	"LICENSE"
	"pubspec.yaml"
	".gitignore"
	"example/lib/main.dart"
	"lib/$packageName.dart"
	"scripts/analyze.sh"
	"scripts/publish.sh"
	"scripts/test.sh"
	"scripts/validate.sh"
)

for file in ${files[@]}; do
	if [[ -f $file ]]; then
		logCheck "$file"
	else
		logUnCheck "$file"
		throwAndExit "FILE_NOT_FOUND_ERROR" "$file does not exist."
	fi
done

#
# Validating pubspec
#
logStep "Validating pubspec"

declare -A patterns
patterns=(
	["name"]="^name: $packageName$"
	["version"]="^version: [0-9]+[.][0-9]+[.][0-9]+$"
	["description"]="^description: .{60,}$"
	["homepage"]="^homepage: https://zamstation.com$"
	["repository"]="^repository: https://github.com/zamstation/$packageName$"
	["environment"]="^environment:$"
	["environment-sdk"]="^  sdk: \">=2.12.0 <3.0.0\"$"
)

for field in "${!patterns[@]}"; do
	matches=$(grep -cE "${patterns[$field]}" "pubspec.yaml")
	if [ $matches -eq 1 ]; then
		logCheck "$field"
	else
		logUnCheck "$field"
		throwAndExit "PUBSPEC_VALIDATION_ERROR" "$field field is invalid.\n\tExpected Format:${patterns[$field]}"
	fi
done

#
# END
#
logEnd
exit 0

#-----------------------------------------------------------------------------
