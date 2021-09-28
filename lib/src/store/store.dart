import 'object_not_found_in_store.exception.dart';

///
/// A key value store that saves objects by `Type`
///
class Store {
  final Map<Type, Object> _objects;

  Map<Type, Object> get objects => Map.unmodifiable(_objects);

  Store([
    Map<Type, Object>? initialList,
  ]) : _objects = initialList ?? {};

  Store save(Object object) {
    final key = object.runtimeType;
    _objects[key] = object;
    return this;
  }

  Store saveMultiple(Iterable<Object> objects) {
    objects.forEach(save);
    return this;
  }

  ///
  /// Copies objects from another store.
  ///
  Store copyObjectsFrom(Store store) {
    _objects.addAll(store.objects);
    return this;
  }

  ///
  /// Copies objects from another store.
  ///
  Store mergeWith(Store store) {
    copyObjectsFrom(store);
    return this;
  }

  bool contains(Type key) {
    return _objects.containsKey(key);
  }

  bool doesNotContain(Type key) {
    return !contains(key);
  }

  ///
  /// Retrieves the object from store.
  ///
  /// If the key is not found, DataNotFoundInStoreException is thrown.
  ///
  T get<T extends Object>() {
    final key = T;
    if (doesNotContain(key)) {
      throw ObjectNotFoundInStoreException(key.toString());
    }

    final object = _objects[key]! as T;
    return object;
  }

  Store remove(Type key) {
    _objects.remove(key);
    return this;
  }

  ///
  /// Remove all the objects from store.
  ///
  Store clear() {
    _objects.clear();
    return this;
  }
}
