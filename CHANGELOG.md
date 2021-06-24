# 0.3.0
- **BREAKING:** Fixed spelling mistake in `CustomTransformer` class name.

# 0.2.0
- **BREAKING:** Removed `key` from constructors of all the `EventTransformers'`.
- Removed logging ability from `EventBus`.
- Added `LoggingEventBus`.

# 0.1.0
- **BREAKING:** Removed `lib/exceptions.dart`.
- Updated dependency: `zam_core 0.5.0`.
- Updated dependency: `zam_command_pattern 0.1.0`.
- Updated dependency: `dart sdk ">=2.13.0 <3.0.0"`.
- Removed dependency: `rxdart` as it is included in `zam_core` now.

# 0.0.1
- Includes `EventBus`.
- Includes `EventTransformer`.
- Includes `Store`.
- Includes the following transformers:
  - `AsyncEventTransformer`
  - `ReactiveEventTransformer`
  - `EventMultiplier`
  - `SavingAsyncEventTransformer`
  - `SavingReactiveEventTransformer`
  - `SavingEventMultiplier`
  - `CustomTransformer`
- Includes the following utilities:
  - `UseCase`
  - `BasicUseCase`
  - `UseCaseBuilder`
  - `UseCaseCompletedEvent`
  - `UseCaseSucceededEvent`
  - `UseCaseFailedEvent`
  - `UseCaseEventTransformer`
  - `SavingUseCaseEventTransformer`
  - `CustomUseCaseEventTransformer`
