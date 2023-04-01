import 'package:shifter_core/src/shifter/models/gear.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';

abstract class IShifterPositionMapper {
  int get id;
  String get name;

  bool isGear(ShifterPosition position);
  bool hasGear(Gear gear);
  ShifterPosition mapGear(Gear gear);
  Gear mapPosition(ShifterPosition position);

  Map<ShifterPosition, Gear> toMap();
}

class ShifterPositionMapper implements IShifterPositionMapper {
  const ShifterPositionMapper({
    required this.id,
    required this.name,
    required this.targetMap,
  });

  @override
  final int id;

  @override
  final String name;

  final Map<ShifterPosition, Gear> targetMap;

  @override
  bool isGear(ShifterPosition position) {
    return targetMap.containsKey(position);
  }

  @override
  bool hasGear(Gear gear) {
    if(gear == Gear.undefined) throw _getException(gear);
    return targetMap.containsValue(gear);
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

  @override
  Map<ShifterPosition, Gear> toMap() => targetMap;
}