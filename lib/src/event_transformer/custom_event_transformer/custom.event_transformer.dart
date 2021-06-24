import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';

///
/// `EventBus` is made available in the `transformFunction`.
///
class CustomEventTranformer<EVENT extends Object>
    implements EventTransformer<EVENT> {
  @override
  final Type key = EVENT;
  final void Function(EVENT event, EventBus bus) _transformerFunction;

  CustomEventTranformer(
      void Function(EVENT event, EventBus bus) transformerFunction)
      : _transformerFunction = transformerFunction;

  @override
  void execute(EVENT event, EventBus bus) {
    _transformerFunction(event, bus);
  }
}
