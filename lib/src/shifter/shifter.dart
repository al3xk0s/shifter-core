// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:shifter_core/src/common/observable/obs.dart';
import 'package:shifter_core/src/shifter/core/shifter_core.dart';
import 'package:shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';
import 'package:shifter_core/src/shifter/models/shifter_event.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';

abstract class IShifter {
  bool get isActive;
  bool get isLocked;

  IReadonlyObs<ShifterPosition> get position;
  IReadonlyObs<Gear> get gear;

  void setCore(IShifterCore newCore);

  void handleShifterEvent(IShifterEvent event);

  IShifterPositionMapper get mapper;
}

class Shifter implements IShifter {
  Shifter(IShifterCore core)
    : _core = core,
      gear = core.gear.obs,
      position = core.position.obs;

  IShifterCore _core;

  @override
  void setCore(IShifterCore newCore) {
    _core = newCore;
    _updateObsValues();
  }
  
  @override
  final IObs<ShifterPosition> position;

  @override
  final IObs<Gear> gear;

  @override
  bool get isActive => _core.isActive;

  @override
  bool get isLocked => _core.isLocked;

  @override
  void handleShifterEvent(IShifterEvent event) {
    event.apply(_core);
    _updateObsValues();
  }

  void _updateObsValues() {
    gear.setValue(_core.gear);
    position.setValue(_core.position);
  }
  
  @override
  IShifterPositionMapper get mapper => _core.mapper;
}