import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'saving.async.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a future
/// - Resolves the future
/// - Publishes the message
/// - Saves the message to store
///
class WrappedSavingAsyncEventTransformer<EVENT extends Object,
        NEW_EVENT extends Object>
    extends SavingAsyncEventTransformer<EVENT, NEW_EVENT> {
  final ParameterizedCallback<EVENT, Future<NEW_EVENT>> _transformFunction;

  const WrappedSavingAsyncEventTransformer(this._transformFunction);

  Future<NEW_EVENT> execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}
