import 'package:dart_shifter_core/src/common/observable/observable.dart';

abstract class IReadonlyObs<T> {
  T get value;
  bool get shouldUpdateEqualValues;

  Disposer listen(Handler<T> handler);
}

abstract class IObs<T> extends IReadonlyObs<T> {
  void setValue(T newValue);
  void setShouldUpdateEqualValues(bool shouldUpdateEqualValues);

  void dispose();
}

class Obs<T> implements IObs<T> {
  Obs(T initialValue, { bool shouldUpdateEqualValues = false })
    : _value = initialValue, 
      _shouldUpdateEqualValue = shouldUpdateEqualValues;

  @override
  void dispose() {
    _observable.dispose();
  }

  @override
  Disposer listen(Handler<T> handler) {
    return _observable.addHandler(handler);
  }

  @override
  void setShouldUpdateEqualValues(bool shouldUpdateEqualValue) {
    _shouldUpdateEqualValue = shouldUpdateEqualValue;
  }

  @override
  void setValue(T newValue) {
    T oldValue = _value;
    _value = newValue;
    if(!shouldUpdateEqualValues && oldValue == newValue) return;
    _observable.notify(_value);
  }

  @override
  bool get shouldUpdateEqualValues => _shouldUpdateEqualValue;

  @override
  T get value => _value;

  @override
  bool operator ==(covariant IReadonlyObs<T> other)
    => identical(this, other) || value == other.value;

  @override
  int get hashCode => value.hashCode;

  T _value;
  bool _shouldUpdateEqualValue;
  final IObservable<T> _observable = Observable<T>();
}

extension ObsExtention<T> on T {
  IObs<T> get obs => Obs(this);
}