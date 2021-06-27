import 'package:zam_core/zam_core.dart';
import 'package:zam_event_bus/zam_event_bus.dart';

///
/// A generalized utility class to
/// configure and run user interface.
///
abstract class UserInterface
    implements AsyncInitializable, AsyncDisposable, AsyncRunnable {
  EventBus get eventBus;
}
