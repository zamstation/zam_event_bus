import '../../event_bus/event_bus.dart';
import '../../event_transformer/event_transformer.dart';
import '../use_case/use_case.builder.dart';
import 'saving.use_case.event_transformer.dart';

class UseCaseEventTransformer<EVENT extends Object>
    implements EventTransformer<EVENT> {
  @override
  final Type key;
  final UseCaseBuilder<EVENT> _useCaseBuilder;

  const UseCaseEventTransformer(this.key, this._useCaseBuilder);

  factory UseCaseEventTransformer.withSave(
    Type key,
    UseCaseBuilder<EVENT> useCaseBuilder,
  ) =>
      SavingUseCaseEventTransformer(key, useCaseBuilder);

  @override
  void execute(EVENT event, EventBus bus) {
    final stream = _useCaseBuilder(event).execute();
    bus.publishFromStream(stream, key.toString());
  }
}
