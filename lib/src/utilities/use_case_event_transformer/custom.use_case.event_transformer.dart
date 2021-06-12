import '../../event_bus/event_bus.dart';
import '../use_case/use_case.dart';
import 'use_case.event_transformer.dart';

class CustomUseCaseEventTransformer<EVENT extends Object>
    implements UseCaseEventTransformer<EVENT> {
  @override
  final Type key;
  final UseCase Function(EVENT event, EventBus bus) _useCaseBuilder;

  const CustomUseCaseEventTransformer(this.key, this._useCaseBuilder);

  @override
  void execute(EVENT event, EventBus bus) {
    _useCaseBuilder(event, bus).execute();
  }
}
