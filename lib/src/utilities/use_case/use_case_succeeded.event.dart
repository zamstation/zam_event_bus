import 'use_case_completed.event.dart';

class UseCaseSucceededEvent<DATA extends Object>
    implements UseCaseCompletedEvent {
  final DATA data;

  const UseCaseSucceededEvent(this.data);
}
