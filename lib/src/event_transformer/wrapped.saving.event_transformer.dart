import 'package:zam_core/callback.dart';

import '../event_bus/event_bus.dart';
import 'saving.event_transformer.dart';

///
/// Transforms an event to another event and saves it to store.
///
class WrappedSavingEventTransformer<EVENT extends Object,
    NEW_EVENT extends Object> extends SavingEventTransformer<EVENT, NEW_EVENT> {
  final ParameterizedCallback<EVENT, NEW_EVENT> _transformFunction;

  const WrappedSavingEventTransformer(this._transformFunction);

  NEW_EVENT execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}
