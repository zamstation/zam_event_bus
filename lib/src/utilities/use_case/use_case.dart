import 'package:zam_command_pattern/zam_command_pattern.dart'
    show ParameterizedReactiveCommand;

import 'use_case_completed.event.dart';

abstract class UseCase<EVENT extends Object>
    implements ParameterizedReactiveCommand<EVENT, UseCaseCompletedEvent> {}
