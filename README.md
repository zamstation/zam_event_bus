# Event Bus

A State Management Package for flutter. 

Use it in conjunction with [zam_event_bus_provider](https://pub.dev/packages/zam_event_bus_provider).

[![Version](https://img.shields.io/pub/v/zam_event_bus?color=%234287f5)](https://pub.dev/packages/zam_event_bus)
[![Build](https://github.com/zamstation/zam_event_bus/actions/workflows/build.yaml/badge.svg)](https://github.com/zamstation/zam_event_bus/actions/workflows/build.yaml)
[![Stars](https://img.shields.io/github/stars/zamstation/zam_event_bus.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/zamstation/zam_event_bus/stargazers)
[![License](https://img.shields.io/github/license/zamstation/zam_event_bus)](https://pub.dev/packages/zam_event_bus/license)

## What's inside the package

Includes the following core components.

  * [EventBus](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/EventBus-class.html)
  * [EventTransformer](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/EventTransformer-class.html)

Check out all the components in detail [here](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/zam_event_bus-library.html)

## How to use

***INFO:** For flutter usage and providing `EventBus` to widgets, checkout the [zam_event_bus_provider](https://pub.dev/packages/zam_event_bus_provider) package.*

### Step 1: Create the bus
```dart
final bus = EventBus([
  EventTransformer(HeightSliderDraggedEvent, (event) => HeightProvidedEvent(event.value)),
  EventTransformer(HeightInputTextChangedEvent, (event) => HeightProvidedEvent(event.value)),
  EventTransformer(WeightSliderDraggedEvent, (event) => WeightProvidedEvent(event.value)),
  EventTransformer(WeightInputTextChangedEvent, (event) => WeightProvidedEvent(event.value)),
  EventTransformer(HeightProvidedEvent, (event) => Bmi.fromHeight(event.value)),
  EventTransformer(WeightProvidedEvent, (event) => Bmi.fromWeight(event.value)),
]);
```

### Step 2: Publish Events
```dart
bus.publish(HeightSliderDraggedEvent(1.78));
```

### Step 3: Select Events

```dart
final sub = bus.select<Bmi>().listen((event) => print(event.value)); // prints bmi value
```

### Step 4: Dispose the bus
```dart
await sub.cancel();
await bus.dispose();
```

To learn more, move on to the [example section](https://pub.dev/packages/zam_event_bus/example) or check out this dedicated [example in github](https://github.com/zamstation/zam_event_bus/blob/main/example/lib/main.dart).

## Contributors
  * [Amsakanna](https://github.com/amsakanna)
