import 'package:zam_event_bus/zam_event_bus.dart';

void main() async {
  // Create the bus by providing in the event transformers.
  // PrepareBmiInputFromHeightUseCase, PrepareBmiInputFromWeightUseCase
  // and CalculateBmiUseCase are event transformers that, as
  // the name indicates, transforms one event to another event.
  final bus = EventBus.withLogger([
    PrepareBmiInputFromHeightUseCase(),
    PrepareBmiInputFromWeightUseCase(),
    CalculateBmiUseCase(),
  ]);

  // Save initial weight and height values to store.
  print('Initializing:');
  bus.save(BmiInputProvidedEvent(80.0, 1.80));

  print('\nSetting up listeners:');
  // Listen to the calculated BMI.
  final successSub = bus.select<BmiCalculatedEvent>().listen(
        (event) => print('- BMI: ${event.data}'),
      ); // prints bmi value on each emit.
  // Listen to exceptions.
  final failureSub = bus.select<BmiCalculateFailedEvent>().listen(
        (event) => print('- Exception: ${event.exception}'),
      ); // prints exception as it occures.

  // Publish events from UI.
  // 10 milliseconds of delay is added between events,
  // so that messages are logged in order.
  print('\nPublishing WeightProvidedEvent(76.0):');
  bus.publish(WeightProvidedEvent(76.0));
  await Future.delayed(Duration(milliseconds: 10));

  print('\nPublishing HeightProvidedEvent(-162.4):');
  bus.publish(HeightProvidedEvent(-162.4));
  await Future.delayed(Duration(milliseconds: 10));

  print('\nPublishing WeightProvidedEvent(0):');
  bus.publish(WeightProvidedEvent(0));
  await Future.delayed(Duration(milliseconds: 10));

  print('\nPublishing HeightProvidedEvent(1.72):');
  bus.publish(HeightProvidedEvent(1.72));
  await Future.delayed(Duration(milliseconds: 10));

  print('\nPublishing WeightProvidedEvent(64):');
  bus.publish(WeightProvidedEvent(64));
  await Future.delayed(Duration(milliseconds: 10));

  // Cleanup
  await successSub.cancel();
  await failureSub.cancel();
  // await inputSub.cancel();
  await bus.dispose();
}

///
/// Events
///
class WeightProvidedEvent {
  final double value;

  const WeightProvidedEvent(this.value);
}

class HeightProvidedEvent {
  final double value;

  const HeightProvidedEvent(this.value);
}

class BmiInputProvidedEvent implements UseCaseEvent {
  final double weight;
  final double height;

  const BmiInputProvidedEvent(this.weight, this.height);
}

class BmiCalculatedEvent extends UseCaseSucceededEvent<Bmi> {
  const BmiCalculatedEvent(Bmi data) : super(data);
}

class BmiCalculateFailedEvent extends UseCaseFailedEvent {
  const BmiCalculateFailedEvent(Exception exception) : super(exception);
}

///
/// Exceptions
///
class InvalidWeightException implements Exception {
  @override
  toString() => 'Weight must be positive';
}

class InvalidHeightException implements Exception {
  @override
  toString() => 'Height must be positive';
}

///
/// Domain Model
///
class Bmi {
  final double weight;
  final double height;
  late final double value;

  Bmi(this.weight, this.height) {
    if (weight <= 0) throw InvalidWeightException();
    if (height <= 0) throw InvalidHeightException();
    value = weight / (height * height);
  }

  @override
  toString() => value.toStringAsFixed(2);
}

///
/// Whenever WeightProvidedEvent arrives,
/// weight value is extracted from the event,
/// height value is retrieved from the store,
/// BmiInputSubmittedEvent is saved and published.
///
class PrepareBmiInputFromWeightUseCase
    extends SavingUseCase<WeightProvidedEvent> {
  @override
  UseCaseEvent execute(WeightProvidedEvent event, EventBus bus) {
    final weight = event.value;
    final height = bus.selectFromStore<BmiInputProvidedEvent>().height;
    return BmiInputProvidedEvent(weight, height);
  }
}

///
/// Whenever HeightProvidedEvent arrives,
/// weight value is retrieved from the store,
/// height value is extracted from the event,
/// BmiInputSubmittedEvent is saved and published.
///
class PrepareBmiInputFromHeightUseCase
    extends SavingUseCase<HeightProvidedEvent> {
  @override
  UseCaseEvent execute(HeightProvidedEvent event, EventBus bus) {
    final weight = bus.selectFromStore<BmiInputProvidedEvent>().weight;
    final height = event.value;
    return BmiInputProvidedEvent(weight, height);
  }
}

///
/// Whenever BmiInputSubmittedEvent arrives,
/// weight and height values are extracted from the event,
/// BMI is calculated.
/// If BMI calculation succeeds,
///   BmiCalculatedEvent is published with data.
/// If BMI calculation fails,
///   BmiCalculateFailedEvent is published with exception.
///
class CalculateBmiUseCase extends UseCase<BmiInputProvidedEvent> {
  @override
  UseCaseEvent execute(BmiInputProvidedEvent event, EventBus bus) {
    print('- Weight: ${event.weight}, Height: ${event.height}');
    try {
      final bmi = Bmi(event.weight, event.height);
      return BmiCalculatedEvent(bmi);
    } catch (exception) {
      if (exception is InvalidWeightException) {
        return BmiCalculateFailedEvent(exception);
      } else if (exception is InvalidHeightException) {
        return BmiCalculateFailedEvent(exception);
      } else {
        rethrow;
      }
    }
  }
}
