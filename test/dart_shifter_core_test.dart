import 'package:shifter_core/shifter_core.dart';
import 'package:test/test.dart';

import 'motion_case_data.dart';

void main() {
  group('Reaction on unlocked switch', unlockedSwitchGroupTestExecutor);

  group('Reaction on locked switch', lockedSwitchGroupTestExecutor);

  group('Automatic switch', automaticSwitchGroupTestExecutor);
}

automaticSwitchGroupTestExecutor() {
  test('to neutral on dismiss unlocked', () {
    final shifter = createShifter(Gear.neutral, isActive: true, isLocked: false);
    shifter.handleShifterEvent(ShifterEvent.left);
    expect(shifter.gear.value, Gear.undefined);
    shifter.handleShifterEvent(ShifterEvent.dismiss);
    expect(shifter.gear.value, Gear.neutral);
  });

  test('on locked dismiss', () {
    final shifter = createShifter(Gear.neutral, isActive: true, isLocked: false);
    shifter.handleShifterEvent(ShifterEvent.left);
    expect(shifter.gear.value, Gear.undefined);
    shifter.handleShifterEvent(ShifterEvent.lock);
    shifter.handleShifterEvent(ShifterEvent.dismiss);
    expect(shifter.gear.value, Gear.undefined);
    shifter.handleShifterEvent(ShifterEvent.unlock);
    expect(shifter.gear.value, Gear.neutral);
  });
}

void unlockedSwitchGroupTestExecutor() {
  final notOverflowedData = [
    MotionCaseData(
      Gear.neutral,
      ShifterEvent.up,
      Gear.third,
      ShifterPosition(VerticalPosition.up, HorizontalPosition(1)),
    ),

    MotionCaseData(
      Gear.neutral,
      ShifterEvent.down,
      Gear.fourth,
      ShifterPosition(VerticalPosition.down, HorizontalPosition(1)),
    ),

    MotionCaseData(
      Gear.neutral,
      ShifterEvent.left,
      Gear.undefined,
      ShifterPosition(VerticalPosition.middle, HorizontalPosition(0)),
    ),

    MotionCaseData(
      Gear.neutral,
      ShifterEvent.right,
      Gear.undefined,
      ShifterPosition(VerticalPosition.middle, HorizontalPosition(2)),
    ),
  ];


  final overflowedData = notOverflowedData
    .map((d) => d.copy(repeat: 10));

  final dates = [
    ...notOverflowedData,
    ...overflowedData,
  ];

  for (var data in dates) {
    test(data.name, getMotionTestCase(data)); 
  }
}

void lockedSwitchGroupTestExecutor() {
  final baseData = MotionCaseData(
      Gear.neutral,
      ShifterEvent.up,
      Gear.neutral,
      ShifterPosition(VerticalPosition.middle, HorizontalPosition(1)),
  );

  final notActive = baseData.copy(isActive: false, isLocked: false);
  final locked = baseData.copy(isActive: true, isLocked: true);
  final lockedNotActive = baseData.copy(isActive: false, isLocked: true);

  test('locked', getMotionTestCase(locked));

  test('not active', getMotionTestCase(notActive));

  test('locked and not active', getMotionTestCase(lockedNotActive));
}

IShifter createShifter(Gear initial, {bool isActive = false, bool isLocked = true}) {
  final mapper = FivePeakPositionMapper();
  final gearCaclulator = ShifterGearCalculator(mapper,  const ShifterPositionCalculator());
  final core = MechanicalShifterCore(
    mapper: mapper,
    calculator: gearCaclulator,
    initialGear: initial,
    isActive: isActive,
    isLocked: isLocked,
  );

  return Shifter(core);
}

void Function() getMotionTestCase(
  MotionCaseData data,
) {
  return () {
    final shifter = createShifter(data.initial, isActive: data.isActive, isLocked: data.isLocked);

    for(int i = 0; i < data.repeat; i++) {
      shifter.handleShifterEvent(data.event);
    }

    final actualGear = shifter.gear.value;
    final actualPosition = shifter.position.value;

    expect(actualGear, data.expectedGear);
    expect(actualPosition, data.expectedPosition);
  };
}