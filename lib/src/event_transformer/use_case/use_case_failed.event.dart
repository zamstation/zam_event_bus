import 'use_case.event.dart';

class UseCaseFailedEvent implements UseCaseEvent {
  final Exception exception;

  const UseCaseFailedEvent(this.exception);
}
