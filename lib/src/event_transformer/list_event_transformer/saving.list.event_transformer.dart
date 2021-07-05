import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'list.event_transformer.dart';
import 'wrapped.saving.list.event_transformer.dart';

///
/// Transforms an event to multiple events and saves them to store.
///
abstract class SavingListEventTransformer<EVENT extends Object>
    extends ListEventTransformer<EVENT> {
  const SavingListEventTransformer();

  factory SavingListEventTransformer.fromFn(
          ParameterizedCallback<EVENT, List<Object>> transformFunction) =>
      WrappedSavingListEventTransformer(transformFunction);

  @override
  void publish(List<Object> newEvent, EventBus bus) {
    bus.publishAndSaveMany(newEvent);
  }
}

typedef SavingEventMultiplier<EVENT extends Object>
    = SavingListEventTransformer<EVENT>;
