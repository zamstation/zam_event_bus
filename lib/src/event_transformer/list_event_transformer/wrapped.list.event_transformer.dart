import 'package:zam_core/callback.dart';

import '../../event_bus/event_bus.dart';
import 'list.event_transformer.dart';

///
/// Transforms an event to multiple events.
///
class WrappedListEventTransformer<EVENT extends Object>
    extends ListEventTransformer<EVENT> {
  final ParameterizedCallback<EVENT, List<Object>> _transformFunction;

  const WrappedListEventTransformer(this._transformFunction);

  List<Object> execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}

typedef WrappedEventMultiplier<EVENT extends Object>
    = WrappedListEventTransformer<EVENT>;
