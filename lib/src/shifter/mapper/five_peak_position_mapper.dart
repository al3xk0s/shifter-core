import 'package:dart_shifter_core/src/common/observable/extentions/map_extention.dart';
import 'package:dart_shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:dart_shifter_core/src/shifter/models/shifter_position.dart';
import 'package:dart_shifter_core/src/shifter/models/gear.dart';

abstract class FivePeakPositionMapperBase extends ShifterPositionMapperBase {
  @override
  Map<ShifterPosition, Gear> getPositionGearMap() {
    return {
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(2))  :  Gear.first,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(2))  :  Gear.undefined,
      ShifterPosition(VerticalPosition.down,    HorizontalPosition(2))  :  Gear.second,
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(3))  :  Gear.third,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(3))  :  Gear.neutral,
      ShifterPosition(VerticalPosition.down,    HorizontalPosition(3))  :  Gear.fourth,
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(4))  :  Gear.fifth,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(4))  :  Gear.undefined,
    };
  }
}

class FivePeakPositionMapper extends FivePeakPositionMapperBase {
  @override
  Map<ShifterPosition, Gear> getPositionGearMap() {
    return super.getPositionGearMap()
      ..put(ShifterPosition(VerticalPosition.down, HorizontalPosition(4)), Gear.back);
  }
}