import 'package:zam_core/zam_core.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';

///
/// Transforms an event to multiple events.
///
class EventMultiplier<EVENT extends Object> implements EventTransformer<EVENT> {
  @override
  final Type key = EVENT;
  final ParameterizedCallback<EVENT, List<Object>> _transformFunction;

  EventMultiplier(ParameterizedCallback<EVENT, List<Object>> transformFunction)
      : _transformFunction = transformFunction;

  EventMultiplier.direct(Type key, List<Object> targetEvents)
      : this((event) => targetEvents);

  @override
  void execute(EVENT event, EventBus bus) {
    final list = _transformFunction(event);
    bus.publishMany(list);
  }
}
