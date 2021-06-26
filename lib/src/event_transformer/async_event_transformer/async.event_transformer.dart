import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';
import 'wrapped.async.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a future
/// - Resolves the future
/// - Publishes the message
///
abstract class AsyncEventTransformer<EVENT extends Object,
        NEW_EVENT extends Object>
    extends EventTransformer<EVENT, Future<NEW_EVENT>> {
  const AsyncEventTransformer();

  factory AsyncEventTransformer.fromFn(
          ParameterizedCallback<EVENT, Future<NEW_EVENT>> transformFunction) =>
      WrappedAsyncEventTransformer(transformFunction);

  @override
  void publish(Future<NEW_EVENT> newEvent, EventBus bus) {
    bus.publishFromFuture(newEvent);
  }
}
