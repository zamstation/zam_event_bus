import 'package:rxdart/rxdart.dart';
import 'package:zam_core/meta.dart';
import 'package:zam_core/zam_core.dart';

import 'use_case.dart';
import 'use_case_completed.event.dart';
import 'use_case_failed.event.dart';
import 'use_case_succeeded.event.dart';

abstract class BasicUseCase<EVENT extends Object, OUTPUT extends Object>
    implements UseCase<EVENT> {
  UseCaseSucceededEvent Function(OUTPUT output) get succeededEventBuilder;
  UseCaseFailedEvent Function(NamedException exception) get failedEventBuilder;

  const BasicUseCase();

  @protected
  Stream<UseCaseCompletedEvent> prepareResponse(OUTPUT output) {
    return output
        .asStream()
        .map<UseCaseCompletedEvent>(succeededEventBuilder)
        .onErrorResume((error, stackTrace) => _buildFailedEventStream(error));
  }

  @protected
  Stream<UseCaseCompletedEvent> prepareResponseFromStream(
      Stream<OUTPUT> outputStream) {
    return outputStream
        .map<UseCaseCompletedEvent>(succeededEventBuilder)
        .onErrorResume((error, stackTrace) => _buildFailedEventStream(error));
  }

  @protected
  Stream<UseCaseCompletedEvent> prepareResponseFromFuture(
      Future<OUTPUT> outputFuture) {
    return outputFuture
        .asStream()
        .map<UseCaseCompletedEvent>(succeededEventBuilder)
        .onErrorResume((error, stackTrace) => _buildFailedEventStream(error));
  }

  Stream<UseCaseFailedEvent> _buildFailedEventStream(Object error) {
    final exception = _filterException(error);
    final response = failedEventBuilder(exception);
    final stream = Stream.value(response);
    return stream;
  }

  NamedException _filterException(Object error) {
    if (error is NamedException) {
      return error;
    } else {
      print('Unhandled Error thrown From ${this.runtimeType}:');
      throw error;
    }
  }
}
