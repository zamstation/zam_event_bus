import 'package:zam_core/zam_core.dart';

import '../../event_bus/event_bus.dart';
import 'async.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a future
/// - Resolves the future
/// - Publishes the message
/// - Saves the message to store
///
class SavingAsyncEventTransformer<EVENT extends Object>
    implements AsyncEventTransformer<EVENT> {
  @override
  final Type key;
  final ParameterizedCallback<EVENT, Future<Object>> _transformFunction;

  const SavingAsyncEventTransformer(this.key, this._transformFunction);

  @override
  void execute(EVENT event, EventBus bus) {
    final future = _transformFunction(event);
    bus.publishAndSaveFromFuture(future);
  }
}
