import 'package:shifter_core/src/shifter/calculate/shifter_position_calculator.dart';
import 'package:shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/direction.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';

class PositionGearPair {
  final ShifterPosition position;
  final Gear? gear;

  PositionGearPair(this.position, [this.gear]);
}

abstract class IShifterGearCalculator {
  PositionGearPair calculate(Direction direction, ShifterPosition from);
}

class ShifterGearCalculator implements IShifterGearCalculator {
  const ShifterGearCalculator(IShifterPositionMapper mapper, IShifterPositionCalculator positionCalculator)
    : _mapper = mapper,
      _positionCalculator = positionCalculator;

  final IShifterPositionMapper _mapper;
  final IShifterPositionCalculator _positionCalculator;

  @override
  PositionGearPair calculate(Direction direction, ShifterPosition from) {
    final newPosition = _positionCalculator.calculate(direction, from);
    if(!_mapper.isGear(newPosition)) return PositionGearPair(from);

    final newGear = _mapper.mapPosition(newPosition);
    return PositionGearPair(newPosition, newGear);
  }
}