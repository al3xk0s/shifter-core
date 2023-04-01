import '../models/gear.dart';
import '../models/shifter_position.dart';
import 'shifter_position_factory.dart';

final sixPeakPositionMapper = createMapper(
  0, 
  'six peak',
  {
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
  }
);

final fivePeakPositionMapper = createMapper(
  1,
  'five peak',
  {
    ShifterPosition(VerticalPosition.up,      HorizontalPosition(0))  :  Gear.first,
    ShifterPosition(VerticalPosition.middle,  HorizontalPosition(0))  :  Gear.undefined,
    ShifterPosition(VerticalPosition.down,    HorizontalPosition(0))  :  Gear.second,
    ShifterPosition(VerticalPosition.up,      HorizontalPosition(1))  :  Gear.third,
    ShifterPosition(VerticalPosition.middle,  HorizontalPosition(1))  :  Gear.neutral,
    ShifterPosition(VerticalPosition.down,    HorizontalPosition(1))  :  Gear.fourth,
    ShifterPosition(VerticalPosition.up,      HorizontalPosition(2))  :  Gear.fifth,
    ShifterPosition(VerticalPosition.middle,  HorizontalPosition(2))  :  Gear.undefined,
    ShifterPosition(VerticalPosition.down,    HorizontalPosition(2))  :  Gear.back,
  }
);