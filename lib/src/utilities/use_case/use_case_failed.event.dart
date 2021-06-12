import 'package:zam_core/zam_core.dart' show NamedException;

import 'use_case_completed.event.dart';

class UseCaseFailedEvent implements UseCaseCompletedEvent {
  final NamedException exception;

  const UseCaseFailedEvent(this.exception);
}
