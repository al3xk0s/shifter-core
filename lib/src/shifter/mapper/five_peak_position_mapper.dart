import 'package:shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';

class FivePeakPositionMapper extends ShifterPositionMapperBase {
  @override
  Map<ShifterPosition, Gear> getPositionGearMap() {
    return {
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(0))  :  Gear.first,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(0))  :  Gear.undefined,
      ShifterPosition(VerticalPosition.down,    HorizontalPosition(0))  :  Gear.second,
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(1))  :  Gear.third,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(1))  :  Gear.neutral,
      ShifterPosition(VerticalPosition.down,    HorizontalPosition(1))  :  Gear.fourth,
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(2))  :  Gear.fifth,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(2))  :  Gear.undefined,
      ShifterPosition(VerticalPosition.down,    HorizontalPosition(2))  :  Gear.back,
    };
  }
}
