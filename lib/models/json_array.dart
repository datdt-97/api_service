import 'dart:math';

import 'json_object.dart';
import 'type_alias.dart';

abstract class _DelegatingIterableBase<E> implements Iterable<E> {
  Iterable<E> get _base;

  const _DelegatingIterableBase();

  @override
  bool any(bool Function(E) test) => _base.any(test);

  @override
  Iterable<T> cast<T>() => _base.cast<T>();

  @override
  bool contains(Object? element) => _base.contains(element);

  @override
  E elementAt(int index) => _base.elementAt(index);

  @override
  bool every(bool Function(E) test) => _base.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E) f) => _base.expand(f);

  @override
  E get first => _base.first;

  @override
  E firstWhere(bool Function(E) test, {E Function()? orElse}) =>
      _base.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) =>
      _base.fold(initialValue, combine);

  @override
  Iterable<E> followedBy(Iterable<E> other) => _base.followedBy(other);

  @override
  void forEach(void Function(E) f) => _base.forEach(f);

  @override
  bool get isEmpty => _base.isEmpty;

  @override
  bool get isNotEmpty => _base.isNotEmpty;

  @override
  Iterator<E> get iterator => _base.iterator;

  @override
  String join([String separator = '']) => _base.join(separator);

  @override
  E get last => _base.last;

  @override
  E lastWhere(bool Function(E) test, {E Function()? orElse}) =>
      _base.lastWhere(test, orElse: orElse);

  @override
  int get length => _base.length;

  @override
  Iterable<T> map<T>(T Function(E) f) => _base.map(f);

  @override
  E reduce(E Function(E value, E element) combine) => _base.reduce(combine);

  @Deprecated('Use cast instead')
  Iterable<T> retype<T>() => cast<T>();

  @override
  E get single => _base.single;

  @override
  E singleWhere(bool Function(E) test, {E Function()? orElse}) {
    return _base.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<E> skip(int n) => _base.skip(n);

  @override
  Iterable<E> skipWhile(bool Function(E) test) => _base.skipWhile(test);

  @override
  Iterable<E> take(int n) => _base.take(n);

  @override
  Iterable<E> takeWhile(bool Function(E) test) => _base.takeWhile(test);

  @override
  List<E> toList({bool growable = true}) => _base.toList(growable: growable);

  @override
  Set<E> toSet() => _base.toSet();

  @override
  Iterable<E> where(bool Function(E) test) => _base.where(test);

  @override
  Iterable<T> whereType<T>() => _base.whereType<T>();

  @override
  String toString() => _base.toString();
}

class JsonArray extends _DelegatingIterableBase<JsonObject>
    with JsonData
    implements List<JsonObject> {
  @override
  final List<JsonObject> _base;

  const JsonArray(List<JsonObject> base) : _base = base;

  const JsonArray.empty() : this(const []);

  /// Creates a wrapper that asserts the types of values in [base].
  ///
  /// This soundly converts a [List] without a generic type to a `List<E>` by
  /// asserting that its elements are instances of `E` whenever they're
  /// accessed. If they're not, it throws a [TypeError]. Note that even if an
  /// operation throws a [TypeError], it may still mutate the underlying
  /// collection.
  ///
  /// This forwards all operations to [base], so any changes in [base] will be
  /// reflected in `this`. If [base] is already a `List<E>`, it's returned
  /// unmodified.
  @Deprecated('Use list.cast<E> instead.')
  static List<E> typed<E>(List base) => base.cast<E>();

  @override
  JsonObject operator [](int index) => _base[index];

  @override
  void operator []=(int index, JsonObject value) {
    _base[index] = value;
  }

  @override
  List<JsonObject> operator +(List<JsonObject> other) => _base + other;

  @override
  void add(JsonObject value) {
    _base.add(value);
  }

  @override
  void addAll(Iterable<JsonObject> iterable) {
    _base.addAll(iterable);
  }

  @override
  Map<int, JsonObject> asMap() => _base.asMap();

  @override
  List<T> cast<T>() => _base.cast<T>();

  @override
  void clear() {
    _base.clear();
  }

  @override
  void fillRange(int start, int end, [JsonObject? fillValue]) {
    _base.fillRange(start, end, fillValue);
  }

  @override
  set first(JsonObject value) {
    if (isEmpty) throw RangeError.index(0, this);
    this[0] = value;
  }

  @override
  Iterable<JsonObject> getRange(int start, int end) =>
      _base.getRange(start, end);

  @override
  int indexOf(JsonObject element, [int start = 0]) =>
      _base.indexOf(element, start);

  @override
  int indexWhere(bool Function(JsonObject) test, [int start = 0]) =>
      _base.indexWhere(test, start);

  @override
  void insert(int index, JsonObject element) {
    _base.insert(index, element);
  }

  @override
  void insertAll(int index, Iterable<JsonObject> iterable) {
    _base.insertAll(index, iterable);
  }

  @override
  set last(JsonObject value) {
    if (isEmpty) throw RangeError.index(0, this);
    this[length - 1] = value;
  }

  @override
  int lastIndexOf(JsonObject element, [int? start]) =>
      _base.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(JsonObject) test, [int? start]) =>
      _base.lastIndexWhere(test, start);

  @override
  set length(int newLength) {
    _base.length = newLength;
  }

  @override
  bool remove(Object? value) => _base.remove(value);

  @override
  JsonObject removeAt(int index) => _base.removeAt(index);

  @override
  JsonObject removeLast() => _base.removeLast();

  @override
  void removeRange(int start, int end) {
    _base.removeRange(start, end);
  }

  @override
  void removeWhere(bool Function(JsonObject) test) {
    _base.removeWhere(test);
  }

  @override
  void replaceRange(int start, int end, Iterable<JsonObject> iterable) {
    _base.replaceRange(start, end, iterable);
  }

  @override
  void retainWhere(bool Function(JsonObject) test) {
    _base.retainWhere(test);
  }

  @Deprecated('Use cast instead')
  @override
  List<T> retype<T>() => cast<T>();

  @override
  Iterable<JsonObject> get reversed => _base.reversed;

  @override
  void setAll(int index, Iterable<JsonObject> iterable) {
    _base.setAll(index, iterable);
  }

  @override
  void setRange(int start, int end, Iterable<JsonObject> iterable,
      [int skipCount = 0]) {
    _base.setRange(start, end, iterable, skipCount);
  }

  @override
  void shuffle([Random? random]) {
    _base.shuffle(random);
  }

  @override
  void sort([int Function(JsonObject, JsonObject)? compare]) {
    _base.sort(compare);
  }

  @override
  List<JsonObject> sublist(int start, [int? end]) => _base.sublist(start, end);
}
