import 'package:shifter_core/src/shifter/models/direction.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';

abstract class IShifterPositionCalculator {
  ShifterPosition calculate(Direction direction, ShifterPosition from);
}

class ShifterPositionCalculator implements IShifterPositionCalculator {
  const ShifterPositionCalculator();

  ShifterPosition onForward(ShifterPosition from) => from.copy(vertical: from.vertical.next());
  ShifterPosition onBack(ShifterPosition from) => from.copy(vertical: from.vertical.previous());

  ShifterPosition onLeft(ShifterPosition from) {
    if(from.vertical != VerticalPosition.middle) return from;
    return from.copy(horizontal: from.horizontal.previous());
  }
  
  ShifterPosition onRight(ShifterPosition from) {
    if(from.vertical != VerticalPosition.middle) return from;
    return from.copy(horizontal: from.horizontal.next());
  }
  
  @override
  ShifterPosition calculate(Direction direction, ShifterPosition from) {
    if(direction == Direction.up) return onForward(from);
    if(direction == Direction.down) return onBack(from);
    if(direction == Direction.left) return onLeft(from);
    if(direction == Direction.right) return onRight(from);

    throw Exception('Unknown direction ${direction.name}');
  }
}