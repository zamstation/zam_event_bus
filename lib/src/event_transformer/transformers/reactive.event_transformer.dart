import 'package:zam_core/zam_core.dart';

import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';

///
/// - Listens to an event
/// - Executes a function that returns a stream
/// - Listens to the stream
/// - Publishes the message as the stream emits
///
class ReactiveEventTransformer<EVENT extends Object>
    implements EventTransformer<EVENT> {
  @override
  final Type key;
  final ParameterizedCallback<EVENT, Stream<Object>> _transformFunction;

  const ReactiveEventTransformer(this.key, this._transformFunction);

  @override
  void execute(EVENT event, EventBus bus) {
    final stream = _transformFunction(event);
    bus.publishFromStream(stream, key.toString());
  }
}
