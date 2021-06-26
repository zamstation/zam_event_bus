import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'async.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a future
/// - Resolves the future
/// - Publishes the message
///
class WrappedAsyncEventTransformer<EVENT extends Object,
    NEW_EVENT extends Object> extends AsyncEventTransformer<EVENT, NEW_EVENT> {
  final ParameterizedCallback<EVENT, Future<NEW_EVENT>> _transformFunction;

  const WrappedAsyncEventTransformer(this._transformFunction);

  Future<NEW_EVENT> execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}
