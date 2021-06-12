# TEMPLATE_GUIDE
***<< [CAUTION]: Remove this file before your first commit. >>***

# CHECKLIST

## pubspec.yaml
- [ ] In name field, replace package_name with your package name.
- [ ] In description field, add description not less than 80 characters.
- [ ] In repository field, replace package_name with your package name.
- [ ] In dependencies field, remove zam_core if not needed.

## README.md
- [ ] Replace @package_title@ with package title.
- [ ] Replace @description@ with description.
- [ ] Replace 18 occurences of @package_name@ with package name.
- [ ] Replace 6 occurences of @component_n@ with component names.
- [ ] Replace @how_to_use@ with usage and examples.
- [ ] Add contributors as necessary.

## lib/package_name.dart
- [ ] Rename package_name.dart to @package_name@.dart
- [ ] Add your files.

## .github/workflows/build.yml
- [ ] Remove "**" from branches-ignore array. Leave "temp".

## test
- [ ] Remove dummy_test.dart when you have created your first test. You need to have at least one test to satisfy the publish.sh script.
- [ ] Remove _setup.dart if not required.

## example/lib/main
- [ ] Add your example.

## CHANGELOG.md
- [ ] Replace @component_n@ with your component names.

## TEMPLATE_GUIDE.md (This File)
- [ ] Remove this file.
