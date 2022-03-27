import 'package:zam_core/zam_core.dart';

import '../event_bus/event_bus.dart';
import '../user_interface/user_interface.dart';

///
/// Application is the class that encompasses
/// user interface and use cases.
///
/// 1. Registers events and use cases.
/// 2. Saves initial data to store.
/// 3. Publishes initial events.
/// 4. Initializes user interface.
/// 5. Runs user interface.
/// 6. Disposes user interface.
/// 7. Disposes bus.
///
abstract class Application
    implements AsyncInitializable, AsyncRunnable, AsyncDisposable {
  UserInterface get userInterface;
  EventBus get eventBus;
}
