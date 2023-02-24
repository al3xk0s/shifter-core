import 'package:shifter_core/src/common/observable/extentions/map_extention.dart';
import 'package:shifter_core/src/shifter/mapper/five_peak_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';

class SixPeakPositionMapper extends FivePeakPositionMapperBase {
  @override
  Map<ShifterPosition, Gear> getPositionGearMap() {
    return super.getPositionGearMap()
      ..put(ShifterPosition(VerticalPosition.down,    HorizontalPosition(4)), Gear.sixth)
      ..put(ShifterPosition(VerticalPosition.up,      HorizontalPosition(1)), Gear.back)
      ..put(ShifterPosition(VerticalPosition.middle,  HorizontalPosition(1)), Gear.undefined);
  }
}