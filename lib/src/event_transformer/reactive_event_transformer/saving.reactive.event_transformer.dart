import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'reactive.event_transformer.dart';
import 'wrapped.saving.reactive.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a stream
/// - Listens to the stream
/// - Publishes the message as the stream emits
/// - Saves the message to store
///
abstract class SavingReactiveEventTransformer<EVENT extends Object,
        NEW_EVENT extends Object>
    extends ReactiveEventTransformer<EVENT, NEW_EVENT> {
  const SavingReactiveEventTransformer();

  factory SavingReactiveEventTransformer.fromFn(
          ParameterizedCallback<EVENT, Stream<NEW_EVENT>> transformFunction) =>
      WrappedSavingReactiveEventTransformer(transformFunction);

  @override
  void publish(Stream<NEW_EVENT> newEvent, EventBus bus) {
    bus.publishAndSaveFromStream(newEvent, key.toString());
  }
}
