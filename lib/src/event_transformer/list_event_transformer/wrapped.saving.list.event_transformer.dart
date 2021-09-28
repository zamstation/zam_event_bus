import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'saving.list.event_transformer.dart';

///
/// Transforms an event to multiple events and saves them to store.
///
class WrappedSavingListEventTransformer<EVENT extends Object>
    extends SavingListEventTransformer<EVENT> {
  final ParameterizedCallback<EVENT, List<Object>> _transformFunction;

  const WrappedSavingListEventTransformer(this._transformFunction);

  @override
  List<Object> execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}

typedef WrappedSavingEventMultiplier<EVENT extends Object>
    = WrappedSavingListEventTransformer<EVENT>;
