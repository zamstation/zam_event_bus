import 'package:zam_core/zam_core.dart';

import '../event_bus/event_bus.dart';
import '../event_transformer/event_transformer.dart';
import '../user_interface/user_interface.dart';
import 'application.dart';

///
/// Holds user interface and use cases.
///
/// 1. Registers events and use cases.
/// 2. Saves initial data to store.
/// 3. Publishes initial events.
/// 4. Initializes user interface.
/// 5. Runs user interface.
/// 6. Disposes user interface.
/// 7. Disposes bus.
///
abstract class BasicApplication implements Application {
  @override
  final UserInterface userInterface;
  @override
  final EventBus eventBus;
  List<EventTransformer> get eventTransformers;

  const BasicApplication(this.userInterface, this.eventBus);

  @override
  @mustCallSuper
  Future<void> initialize() async {
    eventBus.registerTransformers(eventTransformers);
    await userInterface.initialize();
  }

  @override
  @mustCallSuper
  Future<void> run() async {
    await userInterface.run();
  }

  @override
  @mustCallSuper
  Future<void> dispose() async {
    await userInterface.dispose();
    eventBus.dispose();
  }
}
