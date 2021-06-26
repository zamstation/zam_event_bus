import 'use_case.event.dart';

class UseCaseSucceededEvent<DATA extends Object> implements UseCaseEvent {
  final DATA data;

  const UseCaseSucceededEvent(this.data);
}
