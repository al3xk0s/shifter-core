import 'package:shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/direction.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';

abstract class IShifterCore {
  bool get isActive;
  bool get isLocked;

  void setLocked(bool newLocked);
  void setActive(bool newActive);

  void handleDirection(Direction direction);

  ShifterPosition get position;
  Gear get gear;

  IShifterPositionMapper get mapper;
}
