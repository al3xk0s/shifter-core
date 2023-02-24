import 'package:shifter_core/src/shifter/models/shifter_event.dart';

enum Direction {
  forward,
  back,
  left,
  right,
}

Direction? getDirectionAtEvent(ShifterEvent event) {
  const map = {
    ShifterEvent.forward: Direction.forward,
    ShifterEvent.back: Direction.back,
    ShifterEvent.left: Direction.left,
    ShifterEvent.right: Direction.right,
  };

  return map[event];
}