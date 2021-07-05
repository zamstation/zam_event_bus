import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';
import 'wrapped.list.event_transformer.dart';

///
/// Transforms an event to multiple events.
///
abstract class ListEventTransformer<EVENT extends Object>
    extends EventTransformer<EVENT, List<Object>> {
  const ListEventTransformer();

  factory ListEventTransformer.fromFn(
          ParameterizedCallback<EVENT, List<Object>> transformFunction) =>
      WrappedListEventTransformer(transformFunction);

  @override
  void publish(List<Object> newEvent, EventBus bus) {
    bus.publishMany(newEvent);
  }
}

typedef EventMultiplier<EVENT extends Object> = ListEventTransformer<EVENT>;
