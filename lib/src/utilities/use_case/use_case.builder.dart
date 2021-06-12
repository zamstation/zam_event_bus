import 'use_case.dart';

typedef UseCaseBuilder<REQUEST extends Object> = UseCase Function(
    REQUEST request);
