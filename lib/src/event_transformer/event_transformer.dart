import 'package:zam_core/zam_core.dart';

import '../event_bus/event_bus.dart';
import 'transformers/async.event_transformer.dart';
import 'transformers/event_multiplier.dart';
import 'transformers/reactive.event_transformer.dart';

///
/// Transforms an event to another event(s) based on the strategy provided.
///
class EventTransformer<EVENT extends Object> {
  final Type key;
  late final void Function(EVENT event, EventBus bus) _publishStrategy;

  EventTransformer(
    this.key,
    ParameterizedCallback<EVENT, Object> transformFunction,
  ) {
    _publishStrategy = (EVENT event, EventBus bus) {
      final newEvent = transformFunction(event);
      bus.publish(newEvent);
    };
  }

  factory EventTransformer.multiply(
    Type key,
    ParameterizedCallback<EVENT, List<Object>> transformFunction,
  ) =>
      EventMultiplier(key, transformFunction);

  factory EventTransformer.async(
    Type key,
    ParameterizedCallback<EVENT, Future<Object>> transformFunction,
  ) =>
      AsyncEventTransformer(key, transformFunction);

  factory EventTransformer.stream(
    Type key,
    ParameterizedCallback<EVENT, Stream<Object>> transformFunction,
  ) =>
      ReactiveEventTransformer(key, transformFunction);

  void execute(EVENT event, EventBus bus) {
    _publishStrategy(event, bus);
  }
}
