import 'package:zam_core/zam_core.dart';

import '../../zam_event_bus.dart';
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
  @mustCallSuper
  initialize() async {
    eventBus.registerTransformers(eventTransformers);
  }
}
