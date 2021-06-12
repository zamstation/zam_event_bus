import '../../event_bus/event_bus.dart';
import '../use_case/use_case.builder.dart';
import 'use_case.event_transformer.dart';

class SavingUseCaseEventTransformer<EVENT extends Object>
    implements UseCaseEventTransformer<EVENT> {
  @override
  final Type key;
  final UseCaseBuilder<EVENT> _useCaseBuilder;

  const SavingUseCaseEventTransformer(this.key, this._useCaseBuilder);

  @override
  void execute(EVENT event, EventBus bus) {
    final stream = _useCaseBuilder(event).execute();
    bus.publishAndSaveFromStream(stream, key.toString());
  }
}
