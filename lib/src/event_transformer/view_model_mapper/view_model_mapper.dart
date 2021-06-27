import '../saving.event_transformer.dart';

typedef ViewModelMapper<EVENT extends Object, VIEW_MODEL extends Object>
    = SavingEventTransformer<EVENT, VIEW_MODEL>;
