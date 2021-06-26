import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'event_multiplier.dart';

///
/// Transforms an event to multiple events.
///
class WrappedEventMultiplier<EVENT extends Object>
    extends EventMultiplier<EVENT> {
  final ParameterizedCallback<EVENT, List<Object>> _transformFunction;

  const WrappedEventMultiplier(this._transformFunction);

  List<Object> execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}
