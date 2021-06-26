import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'saving.event_multiplier.dart';

///
/// Transforms an event to multiple events and saves them to store.
///
class WrappedSavingEventMultiplier<EVENT extends Object>
    extends SavingEventMultiplier<EVENT> {
  final ParameterizedCallback<EVENT, List<Object>> _transformFunction;

  const WrappedSavingEventMultiplier(this._transformFunction);

  List<Object> execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}
