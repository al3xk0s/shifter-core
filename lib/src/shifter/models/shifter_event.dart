import 'package:shifter_core/shifter_core.dart';

abstract class IShifterEvent {
  void apply(IShifterCore core);

  String get name;

  static const IShifterEvent up = MovingShifterEvent(Direction.up);
  static const IShifterEvent down = MovingShifterEvent(Direction.down);
  static const IShifterEvent left = MovingShifterEvent(Direction.left);
  static const IShifterEvent right = MovingShifterEvent(Direction.right);

  static final IShifterEvent lock = _CallbackShifterEvent((core) => core.setLocked(true), 'lock');
  static final IShifterEvent unlock = _CallbackShifterEvent((core) => core.setLocked(false), 'unlock');
  static final IShifterEvent take = _CallbackShifterEvent((core) => core.setActive(true), 'take');
  static final IShifterEvent dismiss = _CallbackShifterEvent((core) => core.setActive(false), 'dismiss');

  static const IShifterEvent toBack = SetGearShifterEvent(Gear.back);
  static const IShifterEvent toNeutral = SetGearShifterEvent(Gear.neutral);
  static const IShifterEvent toFirst = SetGearShifterEvent(Gear.first);
  static const IShifterEvent toSecond = SetGearShifterEvent(Gear.second);
  static const IShifterEvent toThird = SetGearShifterEvent(Gear.third);
  static const IShifterEvent toFourth = SetGearShifterEvent(Gear.fourth);
  static const IShifterEvent toFifth = SetGearShifterEvent(Gear.fifth);
  static const IShifterEvent toSixth = SetGearShifterEvent(Gear.sixth);
}

class MovingShifterEvent implements IShifterEvent {
  const MovingShifterEvent(this.direction);

  final Direction direction;

  @override
  String get name => direction.name;

  @override
  void apply(IShifterCore core) => core.handleDirection(direction);
}

class _CallbackShifterEvent implements IShifterEvent {
  const _CallbackShifterEvent(this.callback, this.name);

  final void Function(IShifterCore core) callback;

  @override
  final String name;

  @override
  void apply(IShifterCore core) => callback(core);
}

class SetGearShifterEvent implements IShifterEvent {
  const SetGearShifterEvent(this.gear);

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