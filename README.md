# Event Bus

A State Management Package for flutter. 

Use it in conjunction with [zam_event_bus_provider](https://pub.dev/packages/zam_event_bus_provider).

## What's inside the package

Includes the following core components.

- [EventBus](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/EventBus-class.html)
- [EventTransformer](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/EventTransformer-class.html)

Check out all the components in detail [here](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/zam_event_bus-library.html)

## How to use

***INFO:** For flutter usage and providing `EventBus` to widgets, checkout the [zam_event_bus_provider](https://pub.dev/packages/zam_event_bus_provider) package.*

### Step 1: Create the bus
```dart
final bus = EventBus([
  EventTransformer.fromFn((HeightSliderDraggedEvent event) => HeightProvidedEvent(event.value)),
  EventTransformer.fromFn((HeightInputTextChangedEvent event) => HeightProvidedEvent(event.value)),
  EventTransformer.fromFn((WeightSliderDraggedEvent event) => WeightProvidedEvent(event.value)),
  EventTransformer.fromFn((WeightInputTextChangedEvent event) => WeightProvidedEvent(event.value)),
  EventTransformer.fromFn((HeightProvidedEvent event) => Bmi.fromHeight(event.value)),
  EventTransformer.fromFn((WeightProvidedEvent event) => Bmi.fromWeight(event.value)),
]);
```

### Step 2: Publish events
```dart
bus.publish(HeightSliderDraggedEvent(1.78));
```

### Step 3: Select and listen to events

```dart
final sub = bus.select<Bmi>().listen((event) => print(event.value)); // prints bmi value
```

To learn more, move on to the [example section](https://pub.dev/packages/zam_event_bus/example) or check out these dedicated [examples in github](https://github.com/zamstation/zam_event_bus/blob/main/example/lib).

## Status
[![Build](https://github.com/zamstation/zam_event_bus/actions/workflows/build_workflow.yaml/badge.svg)](https://github.com/zamstation/zam_event_bus/actions/workflows/build_workflow.yaml)

## Contributors
- [Amsakanna](https://github.com/amsakanna)

## License
[BSD 3-Clause License](https://github.com/zamstation/zam_event_bus/blob/main/LICENSE)
