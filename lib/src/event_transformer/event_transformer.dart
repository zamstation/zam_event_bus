import 'package:zam_core/callback.dart';

import '../event_bus/event_bus.dart';
import 'wrapped.event_transformer.dart';

///
/// Transforms an event to another event based on the strategy provided.
///
abstract class EventTransformer<EVENT extends Object,
    NEW_EVENT extends Object> {
  Type get key => EVENT;

  const EventTransformer();

  factory EventTransformer.fromFn(
          ParameterizedCallback<EVENT, NEW_EVENT> transformFunction) =>
      WrappedEventTransformer(transformFunction);

  NEW_EVENT execute(EVENT event, EventBus bus);

  void publish(NEW_EVENT newEvent, EventBus bus) {
    bus.publish(newEvent);
  }
}
