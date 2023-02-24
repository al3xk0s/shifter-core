import 'dart:math';

abstract class _BasePosition {
  final int _minValue;
  final int _maxValue;
  final int value;

  const _BasePosition(this._minValue, this._maxValue, this.value)
    : assert(value >= _minValue && value <= _maxValue);

  int _getFixedValue(int newValue) => max(_minValue, min(newValue, _maxValue));

  @override
  bool operator ==(covariant _BasePosition other) => identical(this, other) || value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return value.toString();
  }
}

class VerticalPosition extends _BasePosition {
  const VerticalPosition._(int value) : super(1, 3, value);

  VerticalPosition next() => VerticalPosition._(_getFixedValue(value + 1));
  VerticalPosition previous() => VerticalPosition._(_getFixedValue(value - 1));

  static const VerticalPosition up = VerticalPosition._(3);
  static const VerticalPosition middle = VerticalPosition._(2);
  static const VerticalPosition down = VerticalPosition._(1);
}

class HorizontalPosition extends _BasePosition {
  const HorizontalPosition(int value) : super(1, 10, value);

  HorizontalPosition next() => HorizontalPosition(_getFixedValue(value + 1));
  HorizontalPosition previous() => HorizontalPosition(_getFixedValue(value - 1));
}

class ShifterPosition {
  ShifterPosition(this.vertical, this.horizontal);

  final VerticalPosition vertical;
  final HorizontalPosition horizontal;

  ShifterPosition copy({
    VerticalPosition? vertical,
    HorizontalPosition? horizontal,
  }) => ShifterPosition(vertical ?? this.vertical, horizontal ?? this.horizontal);

  @override
  bool operator ==(covariant ShifterPosition other)
    => identical(this, other) || 
      (vertical == other.vertical && horizontal == other.horizontal);

  @override
  int get hashCode => vertical.value + horizontal.value * 37;

  @override
  String toString() {
    return 'vertical: $vertical, horizontal: $horizontal';
  }
}