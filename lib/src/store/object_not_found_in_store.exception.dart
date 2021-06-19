import 'package:zam_core/zam_core.dart';

///
/// Exception that is thrown when a requested object is not found in store.
///
class ObjectNotFoundInStoreException extends NamedException {
  final String objectKey;

  get problem => 'Object with key \'$objectKey\' not found in store.';
  get solution =>
      'Please insert an object with key \'$objectKey\' before accessing it.';
  get severity => ExceptionSeverity.critical;

  const ObjectNotFoundInStoreException(this.objectKey);
}
