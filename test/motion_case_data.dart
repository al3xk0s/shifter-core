import 'package:shifter_core/src/shifter/models/gear.dart';
import 'package:shifter_core/src/shifter/models/shifter_event.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';

class MotionCaseData {
  final Gear initial;
  final IShifterEvent event;
  final Gear expectedGear;
  final ShifterPosition expectedPosition;
  final int repeat;
  final bool isActive;
  final bool isLocked;

  MotionCaseData(
    this.initial,
    this.event,
    this.expectedGear,
    this.expectedPosition, {
    this.repeat = 1,
    this.isActive = true,
    this.isLocked = false,
  });

  MotionCaseData copy({
    Gear? initial,
    IShifterEvent? event,
    Gear? expectedGear,
    ShifterPosition? expectedPosition,
    int? repeat,
    bool? isActive,
    bool? isLocked,
  }) => MotionCaseData(
    initial ?? this.initial,
    event ?? this.event,
    expectedGear ?? this.expectedGear,
    expectedPosition ?? this.expectedPosition,
    repeat: repeat ?? this.repeat,
    isActive: isActive ?? this.isActive,
    isLocked: isLocked ?? this.isLocked,
  );

  String get name => 'on ${event.name} ${repeat} times';
}