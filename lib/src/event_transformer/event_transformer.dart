import 'package:zam_core/zam_core.dart';

import '../event_bus/event_bus.dart';
import 'async_event_transformer/async.event_transformer.dart';
import 'event_multiplier/event_multiplier.dart';
import 'reactive_event_transformer/reactive.event_transformer.dart';

///
/// Transforms an event to another event based on the strategy provided.
///
class EventTransformer<EVENT extends Object> {
  final Type key = EVENT;
  final ParameterizedCallback<EVENT, Object> _transformFunction;

  EventTransformer(ParameterizedCallback<EVENT, Object> transformFunction)
      : _transformFunction = transformFunction;

  factory EventTransformer.multiply(
          ParameterizedCallback<EVENT, List<Object>> transformFunction) =>
      EventMultiplier(transformFunction);

  factory EventTransformer.async(
    Type key,
    ParameterizedCallback<EVENT, Future<Object>> transformFunction,
  ) =>
      AsyncEventTransformer(transformFunction);

  factory EventTransformer.stream(
    Type key,
    ParameterizedCallback<EVENT, Stream<Object>> transformFunction,
  ) =>
      ReactiveEventTransformer(transformFunction);

  void execute(EVENT event, EventBus bus) {
    final newEvent = _transformFunction(event);
    bus.publish(newEvent);
  }
}
