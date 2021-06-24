import 'package:zam_core/zam_core.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a stream
/// - Listens to the stream
/// - Publishes the message as the stream emits
///
class ReactiveEventTransformer<EVENT extends Object>
    implements EventTransformer<EVENT> {
  @override
  final Type key = EVENT;
  final ParameterizedCallback<EVENT, Stream<Object>> _transformFunction;

  ReactiveEventTransformer(
      ParameterizedCallback<EVENT, Stream<Object>> transformFunction)
      : _transformFunction = transformFunction;

  @override
  void execute(EVENT event, EventBus bus) {
    final stream = _transformFunction(event);
    bus.publishFromStream(stream, key.toString());
  }
}
