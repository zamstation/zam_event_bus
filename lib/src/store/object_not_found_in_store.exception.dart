import 'package:zam_core/zam_core.dart';

///
/// Exception that is thrown when a requested object is not found in store.
///
class ObjectNotFoundInStoreException extends NamedException {
  final String objectKey;

  const ObjectNotFoundInStoreException(this.objectKey)
      : super(
          'Object with key \'$objectKey\' not found in store.',
          solution:
              'Please insert an object with key \'$objectKey\' before accessing it.',
          severity: ExceptionSeverity.critical,
        );
}
