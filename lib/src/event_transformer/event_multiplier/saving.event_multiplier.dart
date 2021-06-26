import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'event_multiplier.dart';
import 'wrapped.saving.event_multiplier.dart';

///
/// Transforms an event to multiple events and saves them to store.
///
abstract class SavingEventMultiplier<EVENT extends Object>
    extends EventMultiplier<EVENT> {
  const SavingEventMultiplier();

  factory SavingEventMultiplier.fromFn(
          ParameterizedCallback<EVENT, List<Object>> transformFunction) =>
      WrappedSavingEventMultiplier(transformFunction);

  @override
  void publish(List<Object> newEvent, EventBus bus) {
    bus.publishAndSaveMany(newEvent);
  }
}
