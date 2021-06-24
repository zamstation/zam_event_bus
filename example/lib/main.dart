import 'package:zam_event_bus/zam_event_bus.dart';

class WeightProvidedEvent {
  final double value;

  const WeightProvidedEvent(this.value);
}

class HeightProvidedEvent {
  final double value;

  const HeightProvidedEvent(this.value);
}

class BmiRequestedEvent {
  final double weight;
  final double height;

  const BmiRequestedEvent(this.weight, this.height);
}

class Bmi {
  final double weight;
  final double height;
  final double value;

  const Bmi(this.weight, this.height) : value = weight / (height * height);
}

void main() async {
  final bus = EventBus.withLogger([
    // Whenever WeightProvidedEvent arrives,
    // weight value is extracted from the event,
    // height value is retrieved from the store,
    // BmiRequestedEvent is prepared and published.
    CustomEventTransformer<WeightProvidedEvent>((event, bus) {
      final weight = event.value;
      final height = bus.selectFromStore<HeightProvidedEvent>().value;
      final newEvent = BmiRequestedEvent(weight, height);
      bus.publishAndSave(newEvent);
    }),

    // Whenever HeightProvidedEvent arrives,
    // height value is extracted from the event,
    // weight value is retrieved from the store,
    // BmiRequestedEvent is prepared and published.
    CustomEventTransformer<HeightProvidedEvent>((event, bus) {
      final weight = bus.selectFromStore<WeightProvidedEvent>().value;
      final height = event.value;
      final newEvent = BmiRequestedEvent(weight, height);
      bus.publishAndSave(newEvent);
    }),

    // Whenever BmiRequestedEvent arrives,
    // BMI is calculated and published
    EventTransformer<BmiRequestedEvent>(
        (event) => Bmi(event.weight, event.height)),
  ]);

  // Save initial weight and height values to store.
  bus.save(WeightProvidedEvent(80.0));
  bus.save(HeightProvidedEvent(1.80));

  // Publish events from UI.
  bus.publish(WeightProvidedEvent(76.0));
  bus.publish(HeightProvidedEvent(1.72));

  // Listen to the calculate BMI.
  final sub = bus
      .select<Bmi>()
      .listen((event) => print(event.value)); // prints bmi value on each emit.

  // Wait for the stream to emit.
  await Future.delayed(Duration(seconds: 1));

  // Cleanup
  await sub.cancel();
  await bus.dispose();
}
