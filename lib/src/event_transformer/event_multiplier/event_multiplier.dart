import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';
import 'wrapped.event_multiplier.dart';

///
/// Transforms an event to multiple events.
///
abstract class EventMultiplier<EVENT extends Object>
    extends EventTransformer<EVENT, List<Object>> {
  const EventMultiplier();

  factory EventMultiplier.fromFn(
          ParameterizedCallback<EVENT, List<Object>> transformFunction) =>
      WrappedEventMultiplier(transformFunction);

  @override
  void publish(List<Object> newEvent, EventBus bus) {
    bus.publishMany(newEvent);
  }
}
