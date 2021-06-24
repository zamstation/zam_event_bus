import 'package:zam_event_bus/src/event_transformer/event_transformer.dart';

import '../event_bus.dart';

///
/// An [EventBus] that logs when publishing, selecting and saving objects.
///
class LoggingEventBus extends EventBus {
  LoggingEventBus([List<EventTransformer>? transformers]) : super(transformers);

  ///
  /// Creates [LoggingEventBus] from [EventBus]
  ///
  LoggingEventBus.fromEventBus(EventBus bus) : super.from(bus);

  LoggingEventBus publish(Object message) {
    print('- [PUBLISHING] ${message.runtimeType}');
    super.publish(message);
    return this;
  }

  LoggingEventBus save(Object message) {
    print('- [SAVING] ${message.runtimeType}');
    super.save(message);
    return this;
  }

  Stream<T> select<T extends Object>() {
    print('- [SELECTING] ${T}');
    return super.select<T>();
  }
}
