import 'package:zam_event_bus/zam_event_bus.dart';
import 'package:zam_test/zam_test.dart';

import '_setup.dart';

void main() {
  StoreTest().execute();
}

class StoreTest extends TestGroup {
  static final store = Store({
    SomeEvent: SomeEvent(),
    SomeOtherEvent: SomeOtherEvent(),
  });

  StoreTest() : super.empty();

  @override
  get tests => [
        DoesNotContainTest(),
        SaveTest(),
      ];
}

class DoesNotContainTest extends Test<Type, bool> {
  @override
  run(input) {
    return StoreTest.store.doesNotContain(SomeOtherEvent);
  }

  @override
  final cases = [
    BooleanTestCase.falsy(
      when: 'When an object is present, doesNotContain',
      input: SomeOtherEvent,
    )
  ];
}

class SaveTest extends Test<SomeOtherEvent1, SomeOtherEvent1> {
  @override
  run(input) {
    StoreTest.store.save(input);
    return StoreTest.store.get<SomeOtherEvent1>();
  }

  @override
  final cases = [
    TestCase(
      when: 'When an object is saved',
      then: 'we should be able to select it.',
      input: SomeOtherEvent1(),
      matcher: isA<SomeOtherEvent1>(),
    )
  ];
}
