# Event Bus

State Management Package  
  
[![Version](https://img.shields.io/pub/v/zam_event_bus?color=%234287f5)](https://pub.dev/packages/zam_event_bus)
[![Build](https://github.com/zamstation/zam_event_bus/actions/workflows/build.yml/badge.svg)](https://github.com/zamstation/zam_event_bus/actions/workflows/build.yml)
[![Stars](https://img.shields.io/github/stars/zamstation/zam_event_bus.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/zamstation/zam_event_bus/stargazers)
[![License](https://img.shields.io/github/license/zamstation/zam_event_bus)](https://pub.dev/packages/zam_event_bus/license)

## What's inside the package

Includes the following core components.

  * [EventBus](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/EventBus-class.html)
  * [EventTransformer](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/EventTransformer-class.html)

Check out all the components in detail [here](https://pub.dev/documentation/zam_event_bus/latest/zam_event_bus/zam_event_bus-library.html)

## How to use

```dart
final bus = EventBus([
  EventTransformer(SomeEvent, (event) => SomeOtherEvent()),
  EventMultiplier.direct(SomeOtherEvent, [SomeOtherEvent1(), SomeOtherEvent2()]),
]);
bus.publish(SomeEvent());
final sub = bus.select<SomeOtherEvent2>().listen(print); // Instance of 'SomeOtherEvent2'

await Future.delayed(Duration(seconds: 1));
await sub.cancel();
await bus.dispose();
```

To learn more, move on to the [example section](https://pub.dev/packages/zam_event_bus/example) or check out this dedicated [example in github](https://github.com/zamstation/zam_event_bus/blob/main/example/lib/main.dart).

## Contributors
  * [Amsakanna](https://github.com/amsakanna)
