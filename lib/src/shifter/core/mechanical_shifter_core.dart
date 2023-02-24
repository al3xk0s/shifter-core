import 'package:shifter_core/src/shifter/calculate/shifter_gear_calculator.dart';
import 'package:shifter_core/src/shifter/core/shifter_core.dart';
import 'package:shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/direction.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';

class MechanicalShifterCore implements IShifterCore {
  MechanicalShifterCore({
    required this.mapper,
    required this.calculator,
    Gear initialGear = Gear.neutral,
    bool isLocked = true,
    bool isActive = false,
  })
    : _gear = initialGear,
      _position = mapper.mapGear(initialGear),
      _isActive = isActive,
      _isLocked = isLocked;

  @override
  Gear get gear => _gear;

  @override
  ShifterPosition get position => _position;

  final IShifterPositionMapper mapper;
  final IShifterGearCalculator calculator;

  @override
  bool get isActive => _isActive;

  @override
  bool get isLocked => _isLocked;

  @override
  void setActive(bool newActive) {
    _isActive = newActive;
    if(!isActive) return _resetUndefinedPosition();
  }

  @override
  void setLocked(bool newLocked) {
    _isLocked = newLocked;
    if(!isLocked) return setActive(_isActive);
  }

  void _trySetPosition(ShifterPosition newPosition, Gear newGear) {
    if(isLocked) return;
    _position = newPosition;
    _gear = newGear;
  }

  @override
  void handleDirection(Direction direction) {
    if(!isActive) return;

    final posPair = calculator.calculate(direction, position);
    final newGear = posPair.gear ?? _gear;
    _trySetPosition(posPair.position, newGear);
  }

  void _resetUndefinedPosition() {
    if(_gear != Gear.undefined) return;
    _trySetPosition(mapper.mapGear(Gear.neutral), Gear.neutral);
  }

  bool _isActive;
  bool _isLocked;
  ShifterPosition _position;
  Gear _gear;
}