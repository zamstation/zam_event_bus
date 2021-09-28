import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'reactive.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a stream
/// - Listens to the stream
/// - Publishes the message as the stream emits
///
class WrappedReactiveEventTransformer<EVENT extends Object,
        NEW_EVENT extends Object>
    extends ReactiveEventTransformer<EVENT, NEW_EVENT> {
  final ParameterizedCallback<EVENT, Stream<NEW_EVENT>> _transformFunction;

  const WrappedReactiveEventTransformer(this._transformFunction);

  @override
  Stream<NEW_EVENT> execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}
