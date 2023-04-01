import 'package:shifter_core/src/common/entity.dart';
import 'package:shifter_core/src/shifter/core/mechanical_shifter_core.dart';
import 'package:shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/direction.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';

abstract class IShifterCore implements IEntity {
  bool get isActive;
  bool get isLocked;

  void setLocked(bool newLocked);
  void setActive(bool newActive);

  void trySetPosition(ShifterPosition newPosition, Gear newGear);
  void handleDirection(Direction direction);

  ShifterPosition get position;
  Gear get gear;

  IShifterPositionMapper get mapper;
}
