import 'package:zam_core/zam_core.dart';

import '../../event_bus/event_bus.dart';
import '../reactive_event_transformer/reactive.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a stream
/// - Listens to the stream
/// - Publishes the message as the stream emits
/// - Saves the message to store
///
class SavingReactiveEventTransformer<EVENT extends Object>
    implements ReactiveEventTransformer<EVENT> {
  @override
  final Type key = EVENT;
  final ParameterizedCallback<EVENT, Stream<Object>> _transformFunction;

  SavingReactiveEventTransformer(
      ParameterizedCallback<EVENT, Stream<Object>> transformFunction)
      : _transformFunction = transformFunction;

  @override
  void execute(EVENT event, EventBus bus) {
    final stream = _transformFunction(event);
    bus.publishAndSaveFromStream(stream, key.toString());
  }
}
