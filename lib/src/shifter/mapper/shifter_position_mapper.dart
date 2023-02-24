import 'package:dart_shifter_core/src/shifter/models/gear.dart';
import 'package:dart_shifter_core/src/shifter/models/shifter_position.dart';

abstract class IShifterPositionMapper {
  bool isGear(ShifterPosition position);
  ShifterPosition mapGear(Gear gear);
  Gear mapPosition(ShifterPosition position);
}

abstract class ShifterPositionMapperBase implements IShifterPositionMapper {
  @override
  bool isGear(ShifterPosition position) {
    return targetMap.containsKey(position);
  }

  @override
  ShifterPosition mapGear(Gear gear) {
    if(gear == Gear.undefined) throw _getException(gear);
    
    final map = targetMap;

    for (var position in map.keys) {
      if(map[position]! == gear) return position;
    }

    throw _getException(gear);
  }

  Exception _getException(Gear gear) => Exception('Unknown position at gear ${gear.name}');

  @override
  Gear mapPosition(ShifterPosition position) {
    return targetMap[position]!;
  }

  Map<ShifterPosition, Gear> getPositionGearMap();

  Map<ShifterPosition, Gear> get targetMap => _map ??= getPositionGearMap();

  Map<ShifterPosition, Gear>? _map;
}