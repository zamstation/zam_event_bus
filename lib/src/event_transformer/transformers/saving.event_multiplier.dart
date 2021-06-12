import 'package:zam_core/zam_core.dart';

import '../../event_bus/event_bus.dart';
import 'event_multiplier.dart';

///
/// Transforms an event to multiple events and saves it to store.
///
class SavingEventMultiplier<EVENT extends Object>
    implements EventMultiplier<EVENT> {
  @override
  final Type key;
  final ParameterizedCallback<EVENT, List<Object>> _transformFunction;

  const SavingEventMultiplier(this.key, this._transformFunction);

  @override
  void execute(EVENT event, EventBus bus) {
    final list = _transformFunction(event);
    bus.publishAndSaveMany(list);
  }
}
