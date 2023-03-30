import 'package:equatable/equatable.dart';
import 'package:shifter_core/shifter_core.dart';

abstract class ShifterEvent extends Equatable {
  ShifterEvent._() : id = _values.length {
    _values.add(this);
  }

  void apply(IShifterCore core);

  @override
  List<Object?> get props => [id];

  final int id;
  String get name;

  static final _values = <ShifterEvent>[];

  static final ShifterEvent up = MovingShifterEvent(Direction.up);
  static final ShifterEvent down = MovingShifterEvent(Direction.down);
  static final ShifterEvent left = MovingShifterEvent(Direction.left);
  static final ShifterEvent right = MovingShifterEvent(Direction.right);

  static final ShifterEvent lock = _CallbackShifterEvent((core) => core.setLocked(true), 'lock');
  static final ShifterEvent unlock = _CallbackShifterEvent((core) => core.setLocked(false), 'unlock');
  static final ShifterEvent take = _CallbackShifterEvent((core) => core.setActive(true), 'take');
  static final ShifterEvent dismiss = _CallbackShifterEvent((core) => core.setActive(false), 'dismiss');

  static final ShifterEvent toBack = SetGearShifterEvent(Gear.back);
  static final ShifterEvent toNeutral = SetGearShifterEvent(Gear.neutral);
  static final ShifterEvent toFirst = SetGearShifterEvent(Gear.first);
  static final ShifterEvent toSecond = SetGearShifterEvent(Gear.second);
  static final ShifterEvent toThird = SetGearShifterEvent(Gear.third);
  static final ShifterEvent toFourth = SetGearShifterEvent(Gear.fourth);
  static final ShifterEvent toFifth = SetGearShifterEvent(Gear.fifth);
  static final ShifterEvent toSixth = SetGearShifterEvent(Gear.sixth);

  factory ShifterEvent.atID(int id) => _values[id];
}

class MovingShifterEvent extends ShifterEvent {
  MovingShifterEvent(this.direction) : super._();

  final Direction direction;

  @override
  String get name => direction.name;

  @override
  void apply(IShifterCore core) => core.handleDirection(direction);
}

class _CallbackShifterEvent extends ShifterEvent {
  _CallbackShifterEvent(this.callback, this.name) : super._();

  final void Function(IShifterCore core) callback;

  @override
  final String name;

  @override
  void apply(IShifterCore core) => callback(core);
}

class SetGearShifterEvent extends ShifterEvent {
  SetGearShifterEvent(this.gear) : super._();

  final Gear gear;
  
  @override
  String get name => gear.name;

  @override
  void apply(IShifterCore core) {
    final currentActive = core.isActive;
    core.setActive(true);

    if(core.mapper.hasGear(gear)) {
      core.trySetPosition(core.mapper.mapGear(gear), gear);
    }

    core.setActive(currentActive);
  }
}