import '../../event_bus/event_bus.dart';
import '../event_transformer.dart';

///
/// `EventBus` is made available in the `transformFunction`.
///
class CustomEventTransformer<EVENT extends Object>
    implements EventTransformer<EVENT> {
  @override
  final Type key;
  final Object? Function(EVENT event, EventBus bus) transformFunction;

  const CustomEventTransformer(this.key, this.transformFunction);

  @override
  void execute(EVENT event, EventBus bus) {
    transformFunction(event, bus);
  }
}
