import 'package:zam_core/callback.dart';

import '../event_bus/event_bus.dart';
import 'event_transformer.dart';
import 'wrapped.saving.event_transformer.dart';

///
/// Transforms an event to another event and saves it to store.
///
abstract class SavingEventTransformer<EVENT extends Object,
    NEW_EVENT extends Object> extends EventTransformer<EVENT, NEW_EVENT> {
  const SavingEventTransformer();

  factory SavingEventTransformer.fromFn(
          ParameterizedCallback<EVENT, NEW_EVENT> transformFunction) =>
      WrappedSavingEventTransformer(transformFunction);

  @override
  void publish(NEW_EVENT newEvent, EventBus bus) {
    bus.publishAndSave(newEvent);
  }
}
