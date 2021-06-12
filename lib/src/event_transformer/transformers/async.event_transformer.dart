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
  final Type key;
  final ParameterizedCallback<EVENT, Future<Object>> _transformFunction;

  const AsyncEventTransformer(this.key, this._transformFunction);

  @override
  void execute(EVENT event, EventBus bus) {
    final future = _transformFunction(event);
    bus.publishFromFuture(future);
  }
}
