import 'package:zam_event_bus/zam_event_bus.dart';

class SomeEvent {}

class SomeOtherEvent {}

class SomeOtherEvent1 extends SomeOtherEvent2 {}

class SomeOtherEvent2 {}

class BoringEvent {}

class FunEvent {}

class MyEventTransformer implements EventTransformer<BoringEvent> {
  @override
  final Type key = BoringEvent;

  const MyEventTransformer();

  @override
  void execute(BoringEvent event, EventBus bus) {
    bus.publish(FunEvent());
  }
}
