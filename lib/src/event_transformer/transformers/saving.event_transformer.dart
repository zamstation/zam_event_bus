import 'package:zam_core/zam_core.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';

///
/// Transforms an event to another event and saves it to store.
///
class SavingEventTransformer<EVENT extends Object>
    implements EventTransformer<EVENT> {
  @override
  final Type key;
  final ParameterizedCallback<EVENT, Object> _transformFunction;

  const SavingEventTransformer(this.key, this._transformFunction);

  @override
  void execute(EVENT event, EventBus bus) {
    final newEvent = _transformFunction(event);
    bus.publishAndSave(newEvent);
  }
}
