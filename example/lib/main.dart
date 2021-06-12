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

void main() async {
  final bus = EventBus([
    EventTransformer(SomeEvent, (event) => SomeOtherEvent()),
    EventMultiplier.direct(
        SomeOtherEvent, [SomeOtherEvent1(), SomeOtherEvent2()]),
  ]);
  bus.publish(SomeEvent());
  final sub1 = bus.select<SomeOtherEvent1>().listen(print);
  final sub2 = bus.select<SomeOtherEvent2>().listen(bus.save);

  await Future.delayed(Duration(seconds: 1));

  print(bus.selectFromStore<SomeOtherEvent2>());
  await sub1.cancel();
  await sub2.cancel();
  await bus.dispose();
}
