import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';
import 'wrapped.reactive.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a stream
/// - Listens to the stream
/// - Publishes the message as the stream emits
///
abstract class ReactiveEventTransformer<EVENT extends Object,
        NEW_EVENT extends Object>
    extends EventTransformer<EVENT, Stream<NEW_EVENT>> {
  const ReactiveEventTransformer();

  factory ReactiveEventTransformer.fromFn(
          ParameterizedCallback<EVENT, Stream<NEW_EVENT>> transformFunction) =>
      WrappedReactiveEventTransformer(transformFunction);

  @override
  void publish(Stream<NEW_EVENT> newEvent, EventBus bus) {
    bus.publishFromStream(newEvent, key.toString());
  }
}
