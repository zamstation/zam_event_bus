import '../async_event_transformer/async.event_transformer.dart';
import '../async_event_transformer/saving.async.event_transformer.dart';
import '../event_transformer.dart';
import '../reactive_event_transformer/reactive.event_transformer.dart';
import '../reactive_event_transformer/saving.reactive.event_transformer.dart';
import '../saving.event_transformer.dart';
import 'use_case.event.dart';

typedef UseCase<EVENT extends Object> = EventTransformer<EVENT, UseCaseEvent>;

typedef AsyncUseCase<EVENT extends Object>
    = AsyncEventTransformer<EVENT, UseCaseEvent>;

typedef ReactiveUseCase<EVENT extends Object>
    = ReactiveEventTransformer<EVENT, UseCaseEvent>;

typedef SavingUseCase<EVENT extends Object>
    = SavingEventTransformer<EVENT, UseCaseEvent>;

typedef SavingAsyncUseCase<EVENT extends Object>
    = SavingAsyncEventTransformer<EVENT, UseCaseEvent>;

typedef SavingReactiveUseCase<EVENT extends Object>
    = SavingReactiveEventTransformer<EVENT, UseCaseEvent>;
