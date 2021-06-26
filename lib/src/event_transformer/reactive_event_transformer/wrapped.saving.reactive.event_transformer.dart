import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'saving.reactive.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a stream
/// - Listens to the stream
/// - Publishes the message as the stream emits
/// - Saves the message to store
///
class WrappedSavingReactiveEventTransformer<EVENT extends Object,
        NEW_EVENT extends Object>
    extends SavingReactiveEventTransformer<EVENT, NEW_EVENT> {
  final ParameterizedCallback<EVENT, Stream<NEW_EVENT>> _transformFunction;

  const WrappedSavingReactiveEventTransformer(this._transformFunction);

  Stream<NEW_EVENT> execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}
