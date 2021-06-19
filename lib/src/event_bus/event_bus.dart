import 'package:zam_core/meta.dart';
import 'package:zam_core/zam_core.dart';

import '../event_transformer/event_transformer.dart';
import '../store/store.dart';

///
/// [EventBus] is a stream based solution to remove dependencies between elements.
///
/// Usage:
///
///     final bus = EventBus([
///       EventTransformer(HeightProvidedEvent, (event, eventBus) => BmiCalculatedEvent()),
///       EventTransformer(WeightProvidedEvent, (event, eventBus) => BmiCalculatedEvent()),
///     ]);
///     bus.publish(WeightProvidedEvent());
///     final outputStream = bus.select<BmiCalculatedEvent>();
///
/// You can now listen to the outputStream
///
/// TODO: Find a way to check circular transformations and remove them.
///
@immutable
class EventBus implements AsyncDisposable {
  final _controller = BehaviorSubject<Object>();
  final _transformers = <Type, List<EventTransformer>>{};
  final _subscriptionManager = SubscriptionManager();

  ///
  /// Events are stored here.
  ///
  final store = Store();

  ///
  /// The internal stream is exposed for customized listening.
  ///
  /// Use this only when required.
  /// Use select method instead.
  ///
  Stream<Object> get stream => _controller.stream;

  ///
  /// EventBus will start listening to events when constructed.
  ///
  /// For deferred registration of transformers, use the register method.
  ///
  EventBus([List<EventTransformer>? transformers]) {
    registerTransformers(transformers ?? []);
    _startListenings();
  }

  void _startListenings() {
    stream.listen(_transformEvent).addTo(_subscriptionManager);
  }

  void _transformEvent(Object event) {
    final key = event.runtimeType;

    if (!_transformers.containsKey(key)) return;

    _transformers[key]!
        .forEach((transformer) => transformer.execute(event, this));
  }

  ///
  /// Registered transformers will run when a source event is hit.
  ///
  EventBus registerTransformers(List<EventTransformer> transformers) {
    transformers.forEach((transformer) {
      final key = transformer.key;
      _transformers.containsKey(key)
          ? _transformers[key]!.add(transformer)
          : _transformers[key] = [transformer];
    });
    return this;
  }

  ///
  /// Publishes a single message.
  ///
  EventBus publish(Object message) {
    print('- [PUBLISHING] ${message.runtimeType}');
    _controller.add(message);
    return this;
  }

  ///
  /// Publishes multiple messages.
  ///
  EventBus publishMany(Iterable<Object> messageList) {
    messageList.forEach((message) {
      publish(message);
    });
    return this;
  }

  ///
  /// Publishes the message after resolving a future.
  ///
  EventBus publishFromFuture(Future<Object> future) {
    future.then(publish);
    return this;
  }

  ///
  /// Publishes messages as the stream emits.
  ///
  EventBus publishFromStream(Stream<Object> stream, String id) {
    final subscription = stream.listen(publish);
    _subscriptionManager.replaceById(subscription, id);
    return this;
  }

  EventBus cancelFromStream(String id) {
    _subscriptionManager.removeById(id);
    return this;
  }

  ///
  /// Saves message to store.
  ///
  EventBus save(Object message) {
    print('- [SAVING] ${message.runtimeType}');
    store.save(message);
    return this;
  }

  ///
  /// Publishes and saves messages to store.
  ///
  EventBus publishAndSave(Object message) {
    publish(message);
    save(message);
    return this;
  }

  ///
  /// Publishes and saves multiple messages.
  ///
  EventBus publishAndSaveMany(Iterable<Object> messageList) {
    messageList.forEach(publishAndSave);
    return this;
  }

  ///
  /// Publishes and saves the message after resolving a future.
  ///
  EventBus publishAndSaveFromFuture(Future<Object> future) {
    future.then(publishAndSave);
    return this;
  }

  ///
  /// Publishes and saves messages as the stream emits.
  ///
  EventBus publishAndSaveFromStream(Stream<Object> stream, String id) {
    final subscription = stream.listen(publishAndSave);
    _subscriptionManager.replaceById(subscription, id);
    return this;
  }

  ///
  /// Publishes a message from store.
  ///
  EventBus publishFromStore<T extends Object>() {
    final message = selectFromStore<T>();
    publish(message);
    return this;
  }

  ///
  /// Selects a message of type `T`.
  ///
  Stream<T> select<T extends Object>() {
    print('- [SELECTING] ${T}');
    return stream.whereType<T>();
  }

  ///
  /// Selects a message of type `T` from store.
  ///
  T selectFromStore<T extends Object>() {
    return store.get<T>();
  }

  ///
  /// Disposes the `SubscriptionManager`.
  /// Closes the `StreamController`.
  /// Unregisters all the `Transformers`.
  ///
  @override
  Future<void> dispose() async {
    _subscriptionManager.dispose();
    await _controller.close();
    _transformers.clear();
  }
}