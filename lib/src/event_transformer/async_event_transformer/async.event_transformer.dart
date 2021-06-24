import 'package:zam_core/zam_core.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a future
/// - Resolves the future
/// - Publishes the message
///
class AsyncEventTransformer<EVENT extends Object>
    implements EventTransformer<EVENT> {
  @override
  final Type key = EVENT;
  final ParameterizedCallback<EVENT, Future<Object>> _transformFunction;

  AsyncEventTransformer(
      ParameterizedCallback<EVENT, Future<Object>> transformFunction)
      : _transformFunction = transformFunction;

  @override
  void execute(EVENT event, EventBus bus) {
    final future = _transformFunction(event);
    bus.publishFromFuture(future);
  }
}
