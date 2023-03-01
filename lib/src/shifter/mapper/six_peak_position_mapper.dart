import 'package:shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';

class SixPeakPositionMapper extends ShifterPositionMapperBase {
  @override
  Map<ShifterPosition, Gear> getPositionGearMap() {
    return {
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(0))  :  Gear.back,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(0))  :  Gear.undefined,
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(1))  :  Gear.first,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(1))  :  Gear.undefined,
      ShifterPosition(VerticalPosition.down,    HorizontalPosition(1))  :  Gear.second,
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(2))  :  Gear.third,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(2))  :  Gear.neutral,
      ShifterPosition(VerticalPosition.down,    HorizontalPosition(2))  :  Gear.fourth,
      ShifterPosition(VerticalPosition.up,      HorizontalPosition(3))  :  Gear.fifth,
      ShifterPosition(VerticalPosition.middle,  HorizontalPosition(3))  :  Gear.undefined,
      ShifterPosition(VerticalPosition.down,    HorizontalPosition(3))  :  Gear.sixth,
    };
  }
}
