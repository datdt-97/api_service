import 'type_alias.dart';

class JsonObject with JsonData implements Map<String, dynamic> {
  final Map<String, dynamic> _base;

  const JsonObject(Map<String, dynamic> base) : _base = base;

  const JsonObject.empty() : this(const {});

  /// Creates a wrapper that asserts the types of keys and values in [base].
  ///
  /// This soundly converts a [Map] without generic types to a `Map<K, V>` by
  /// asserting that its keys are instances of `E` and its values are instances
  /// of `V` whenever they're accessed. If they're not, it throws a [TypeError].
  /// Note that even if an operation throws a [TypeError], it may still mutate
  /// the underlying collection.
  ///
  /// This forwards all operations to [base], so any changes in [base] will be
  /// reflected in `this`. If [base] is already a `Map<K, V>`, it's returned
  /// unmodified.
  @Deprecated('Use map.cast<K, V> instead.')
  static Map<K, V> typed<K, V>(Map base) => base.cast<K, V>();

  @override
  dynamic operator [](Object? key) => _base[key];

  @override
  void operator []=(String key, dynamic value) {
    _base[key] = value;
  }

  @override
  void addAll(Map<String, dynamic> other) {
    _base.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<String, dynamic>> entries) {
    _base.addEntries(entries);
  }

  @override
  void clear() {
    _base.clear();
  }

  @override
  Map<K2, V2> cast<K2, V2>() => _base.cast<K2, V2>();

  @override
  bool containsKey(Object? key) => _base.containsKey(key);

  @override
  bool containsValue(Object? value) => _base.containsValue(value);

  @override
  Iterable<MapEntry<String, dynamic>> get entries => _base.entries;

  @override
  void forEach(void Function(String, dynamic) f) {
    _base.forEach(f);
  }

  @override
  bool get isEmpty => _base.isEmpty;

  @override
  bool get isNotEmpty => _base.isNotEmpty;

  @override
  Iterable<String> get keys => _base.keys;

  @override
  int get length => _base.length;

  @override
  Map<K2, V2> map<K2, V2>(
          MapEntry<K2, V2> Function(String, dynamic) transform) =>
      _base.map(transform);

  @override
  dynamic putIfAbsent(String key, dynamic Function() ifAbsent) =>
      _base.putIfAbsent(key, ifAbsent);

  @override
  dynamic remove(Object? key) => _base.remove(key);

  @override
  void removeWhere(bool Function(String, dynamic) test) =>
      _base.removeWhere(test);

  @Deprecated('Use cast instead')
  Map<K2, V2> retype<K2, V2>() => cast<K2, V2>();

  @override
  Iterable<dynamic> get values => _base.values;

  @override
  String toString() => _base.toString();

  @override
  dynamic update(String key, dynamic Function(dynamic) update,
          {dynamic Function()? ifAbsent}) =>
      _base.update(key, update, ifAbsent: ifAbsent);

  @override
  void updateAll(dynamic Function(String, dynamic) update) =>
      _base.updateAll(update);
}
