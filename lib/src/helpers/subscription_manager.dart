import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SubscriptionManager extends CompositeSubscription {
  final _subscriptionMap = Map<String, StreamSubscription>();

  SubscriptionManager();

  ///
  /// Adds a subscription by id.
  ///
  StreamSubscription<T> addById<T extends Object>(
      StreamSubscription<T> subscription, String id) {
    _subscriptionMap.addEntries([MapEntry(id, subscription)]);
    return add(subscription);
  }

  void removeById(String id) {
    if (!_subscriptionMap.containsKey(id)) return;

    final subscription = _subscriptionMap[id]!;
    remove(subscription);
  }

  ///
  /// Replaces an existing subscription by id.
  ///
  StreamSubscription<T> replaceById<T extends Object>(
      StreamSubscription<T> subscription, String id) {
    removeById(id);
    return addById(subscription, id);
  }

  @override
  void remove(StreamSubscription<dynamic> subscription) {
    super.remove(subscription);
    _subscriptionMap.removeWhere((id, item) => item == subscription);
  }

  @override
  void clear() {
    super.clear();
    _subscriptionMap.clear();
  }
}
