import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'async.event_transformer.dart';
import 'wrapped.saving.async.event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a future
/// - Resolves the future
/// - Publishes the message
/// - Saves the message to store
///
abstract class SavingAsyncEventTransformer<EVENT extends Object,
    NEW_EVENT extends Object> extends AsyncEventTransformer<EVENT, NEW_EVENT> {
  const SavingAsyncEventTransformer();

  factory SavingAsyncEventTransformer.fromFn(
          ParameterizedCallback<EVENT, Future<NEW_EVENT>> transformFunction) =>
      WrappedSavingAsyncEventTransformer(transformFunction);

  @override
  void publish(Future<NEW_EVENT> newEvent, EventBus bus) {
    bus.publishAndSaveFromFuture(newEvent);
  }
}
