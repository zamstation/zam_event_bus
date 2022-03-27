import '../event_bus/event_bus.dart';
import '../event_transformer/event_transformer.dart';
import 'user_interface.dart';

///
/// A generalized utility class to
/// configure and run user interface.
///
abstract class BasicUserInterface implements UserInterface {
  @override
  final EventBus eventBus;
  List<EventTransformer> get eventTransformers;

  const BasicUserInterface(this.eventBus);

  @override
  Future<void> initialize() async {
    eventBus.registerTransformers(eventTransformers);
  }
}
