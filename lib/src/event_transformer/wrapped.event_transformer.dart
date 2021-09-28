import 'package:zam_core/callback.dart';

import '../event_bus/event_bus.dart';
import 'event_transformer.dart';

///
/// Transforms an event to another event based on the strategy provided.
///
class WrappedEventTransformer<EVENT extends Object, NEW_EVENT extends Object>
    extends EventTransformer<EVENT, NEW_EVENT> {
  final ParameterizedCallback<EVENT, NEW_EVENT> _transformFunction;

  const WrappedEventTransformer(this._transformFunction);

  @override
  NEW_EVENT execute(EVENT event, EventBus bus) {
    return _transformFunction(event);
  }
}
